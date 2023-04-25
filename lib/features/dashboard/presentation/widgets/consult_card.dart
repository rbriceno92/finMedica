import 'package:app/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:app/features/dashboard/presentation/widgets/consults_empty_state.dart';
import 'package:app/features/dashboard/presentation/widgets/next_consults.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../util/colors_fm.dart';
import '../../../../util/dimens.dart';
import '../bloc/dashboard_state.dart';
import 'dialog_schedule_appointment.dart';

//Widget of the card of consults will show two next consults or empty state
class ConsultCard extends StatelessWidget {
  final bool isEmpty;
  final double heighCard = 320;

  const ConsultCard({Key? key, required this.isEmpty}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      listener: (context, state) {},
      builder: (context, state) {
        return GestureDetector(
            onTap: () {
              state.consult!.isEmpty
                  ? ScheduleAppointmentDashboard.showScheduleAppointmentDialog(
                      context)
                  : null;
            },
            child: Container(
              height: heighCard,
              margin: const EdgeInsets.symmetric(horizontal: marginStandard),
              alignment: Alignment.center,
              child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                color: ColorsFM.blueLight90,
                child: Container(
                    height: heighCard,
                    margin: const EdgeInsets.symmetric(
                        vertical: smallMargin, horizontal: smallMargin),
                    child: !isEmpty
                        ? const NextConsult()
                        : const ConsultEmptyState()),
              ),
            ));
      },
    );
  }
}
