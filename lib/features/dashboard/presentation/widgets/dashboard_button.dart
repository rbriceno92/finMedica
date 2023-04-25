import 'package:app/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:app/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:app/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:app/features/dashboard/presentation/widgets/dialog_schedule_appointment.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/widgets/spinner_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../util/assets_routes.dart';
import '../../../../util/colors_fm.dart';
import '../../../../util/dimens.dart';

class DashboardButtons extends StatelessWidget {
  const DashboardButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      bloc: BlocProvider.of<DashboardBloc>(context),
      listener: (context, state) {
        if (state.loading2 == LoadingState.show) {
          SpinnerLoading.showDialogLoading(context);
        }
        if (state.loading2 == LoadingState.close) {
          Navigator.popUntil(
              context, (route) => route.settings.name == dashboardRoute);
          if (state.isAdmin!) {
            ScheduleAppointmentDashboard.showScheduleAppointmentDialog(context);
          } else {
            Navigator.of(context).pushNamed(directoryRoute);
          }
          context.read<DashboardBloc>().add(DisposeLoading());
        }
      },
      builder: (context, state) => Container(
        padding: EdgeInsets.only(
            bottom: marginStandard + MediaQuery.of(context).padding.bottom,
            left: marginStandard,
            right: marginStandard),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SizedBox(
                height: 56,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsFM.green40, elevation: 0),
                    onPressed: () {
                      context.read<DashboardBloc>().add(GetMyGroupInfo());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(iconSchedule),
                        const SizedBox(
                          width: smallMargin,
                        ),
                        Text(
                          Languages.of(context).schedule,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        )
                      ],
                    )),
              ),
            ),
            const SizedBox(
              width: smallMargin,
            ),
            Expanded(
              child: SizedBox(
                height: 56,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsFM.textInputError, elevation: 0),
                    onPressed: () {
                      Navigator.pushNamed(context, storeRoute);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(iconStore),
                        const SizedBox(
                          width: smallMargin,
                        ),
                        Text(
                          Languages.of(context).services,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        )
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
