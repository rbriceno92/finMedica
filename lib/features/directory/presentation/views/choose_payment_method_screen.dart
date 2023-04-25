import 'package:app/features/directory/data/models/book_appointment_params.dart';
import 'package:app/features/directory/presentation/bloc/book_appointment/book_appointment_event.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/colors_fm.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/widgets/alert_notification.dart';
import 'package:app/util/widgets/button_text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/di/modules.dart';
import '../../../../util/widgets/spinner_loading.dart';
import '../bloc/book_appointment/book_appointment_bloc.dart';
import '../bloc/book_appointment/book_appointment_state.dart';

class ChoosePaymentMethodScreen extends StatelessWidget {
  final BookAppointmentParams timeBooked;
  const ChoosePaymentMethodScreen({super.key, required this.timeBooked});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BookAppointmentBloc>(),
      child: ChoosePaymentMethodView(
        timeBooked: timeBooked,
      ),
    );
  }
}

class ChoosePaymentMethodView extends StatelessWidget {
  final BookAppointmentParams timeBooked;
  const ChoosePaymentMethodView({Key? key, required this.timeBooked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookAppointmentBloc, BookAppointmentState>(
      listener: (context, state) {
        if (state.isLoading) {
          SpinnerLoading.showDialogLoading(context);
        } else if (_isThereCurrentDialogShowing(context)) {
          Navigator.pop(context);
        }
        if (state.errorMessage.isNotEmpty) {
          AlertNotification.error(context, state.errorMessage);
        }
        if (state.bookedAppointment) {
          Navigator.pushNamedAndRemoveUntil(context,
              scheduleAppointmentSuccessRoute, (Route<dynamic> route) => false,
              arguments: false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          // backgroundColor: ColorsFM.primaryLight99,
          appBar: AppBar(
              backgroundColor: ColorsFM.green40,
              title: Text(Languages.of(context).scheduleAppointment)),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: marginStandard),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SvgPicture.asset(iconCuponAdd,
                            height: 86, color: ColorsFM.green40),
                        const SizedBox(
                          height: marginStandard,
                        ),
                        Text(
                          Languages.of(context).noConsultsAvailable,
                          style: TypefaceStyles.poppinsSemiBold22
                              .copyWith(color: ColorsFM.primary),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: marginStandard,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: marginStandard),
                          child: Text(
                            Languages.of(context).canGoStoreToAdd,
                            style: TypefaceStyles.bodyMediumMontserrat,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  ButtonText(
                    text: Languages.of(context).payThisConsult,
                    onPressed: () {
                      Navigator.pushNamed(context, payConsultRoute,
                          arguments: timeBooked);
                    },
                  ),
                  const SizedBox(
                    height: marginStandard,
                  ),
                  GestureDetector(
                    onTap: () {
                      context
                          .read<BookAppointmentBloc>()
                          .add(BookAppointment(params: timeBooked));
                    },
                    child: Text(
                      Languages.of(context).scheduleWithoutPrepay,
                      style: TypefaceStyles.montserrat10.copyWith(height: 1),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: largeDivision,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;
}
