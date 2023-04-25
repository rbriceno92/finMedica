import 'package:app/features/directory/data/models/book_appointment_params.dart';
import 'package:app/features/my_consults/domain/entities/consult.dart';
import 'package:app/features/my_consults/domain/entities/consult_type.dart';
import 'package:app/features/my_consults/presentation/bloc/my_consult_detail_bloc.dart';
import 'package:app/features/my_consults/presentation/bloc/my_consult_detail_event.dart';
import 'package:app/features/my_consults/presentation/bloc/my_consult_detail_state.dart';
import 'package:app/features/my_consults/presentation/widgets/detail_screen/buttons_schedule_consults.dart';
import 'package:app/features/my_consults/presentation/widgets/detail_screen/cancel_alert_consult.dart';
import 'package:app/features/my_consults/presentation/widgets/detail_screen/content_detail_consult.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/widgets/alert_notification.dart';
import 'package:app/util/widgets/spinner_loading.dart';
import 'package:app/util/format_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/di/modules.dart';
import '../../../../util/colors_fm.dart';
import '../../../../util/dimens.dart';
import '../../../../util/fonts_types.dart';

import '../widgets/detail_screen/information_alert_consult.dart';
import '../widgets/open_dialog/open_dialog_confirm_consult.dart';

class MyConsultDetailScreen extends StatelessWidget {
  final Consult consult;
  const MyConsultDetailScreen({Key? key, required this.consult})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MyConsultDetailBloc>()
        ..add(LoadUser())
        ..add(AddConsult(consult))
        ..add(FetchConsultDetail()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(Languages.of(context).consultDetail),
          backgroundColor: (consult.reschedule ?? false)
              ? ColorsFM.green20
              : consult.type.getColorByType(),
        ),
        backgroundColor: ColorsFM.primaryLight99,
        body: const ContentDetailConsult(),
      ),
    );
  }
}

class ContentDetailConsult extends StatelessWidget {
  const ContentDetailConsult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyConsultDetailBloc, MyConsultDetailState>(
      listener: (context, state) {
        if (state.loading == LoadingState.show) {
          SpinnerLoading.showDialogLoading(context);
        }
        if (state.loading == LoadingState.close ||
            state.loading == LoadingState.dispose) {
          if (_isThereCurrentDialogShowing(context)) {
            Navigator.pop(context);
            if (state.goTo == GoTo.choosePayScreen) {
              final bookAppointmentParams = BookAppointmentParams(
                  type: state.consult.timeConsult?.type ?? '',
                  time: state.consult.timeConsult?.time ?? '',
                  date: state.consult.date.dateFormatCalendar(),
                  orden: state.consult.timeConsult?.orden ?? 0,
                  agendaId: state.consult.timeConsult?.schedule ?? 1,
                  personaId: state.consult.patient?.personId ?? 1,
                  specialityId: state.consult.doctor?.professionalId ?? 1,
                  privacy: state.isPrivate);
              Navigator.pushNamed(context, choosePaymentMethodRoute,
                  arguments: bookAppointmentParams);
            } else if (state.goTo == GoTo.successScreen) {
              Navigator.pushNamedAndRemoveUntil(
                  context,
                  scheduleAppointmentSuccessRoute,
                  (Route<dynamic> route) => false,
                  arguments: true);
            }
          }
        }
        if (state.message != '') {
          AlertNotification.error(context, state.message.toString());
        }
        if (state.rescheduledAppointment) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(dashboardRoute, (route) => false);
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            HeaderDetailConsult(
              consultType: state.consult.type,
              speciality: state.consult.speciality ?? '',
              private: state.consult.private,
              reschedule: state.consult.reschedule ?? false,
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: (state.loading != LoadingState.show ||
                              state.consult.type == ConsultType.SCHEDULING)
                          ? IntrinsicHeight(
                              child: state.consult.private
                                  ? getListOfWidgetsPrivacy(context, state)
                                  : getListOfWidgets(context, state))
                          : Container()),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  Column getListOfWidgets(BuildContext context, MyConsultDetailState state) {
    return Column(children: [
      (!state.consult.isReasonEmpty())
          ? InformationAlertConsult(
              reason: state.consult.reason!,
            )
          : Container(),
      BodyDetailConsult(
        consult: state.consult,
      ),
      Expanded(child: Container()),
      state.consult.type == ConsultType.SCHEDULING
          ? Padding(
              padding: const EdgeInsets.all(marginStandard).copyWith(top: 0),
              child: CheckboxSection(mainUser: state.consult.main_user ?? true))
          : Container(),
      if (validateIfAllowToRescheduleAppointment(state))
        Container(
          alignment: Alignment.bottomCenter,
          child: state.consult.type != ConsultType.SCHEDULING
              ? ButtonsMyConsult(
                  consult: state.consult,
                  user: state.user,
                )
              : Padding(
                  padding: const EdgeInsets.all(marginStandard),
                  child: ElevatedButton(
                      onPressed: (state.acceptConditions)
                          ? () {
                              if (state.consult.reschedule != null) {
                                context
                                    .read<MyConsultDetailBloc>()
                                    .add(RescheduleAppointmentEvent());
                              } else {
                                context
                                    .read<MyConsultDetailBloc>()
                                    .add(const OnGetRemainingConsults());
                              }
                            }
                          : null,
                      child: Text(Languages.of(context).continueText)),
                ),
        )
      else if (state.consult.type == ConsultType.REPROGRAMMING ||
          state.consult.type == ConsultType.SCHEDULE)
        Padding(
          padding: const EdgeInsets.all(marginStandard).copyWith(top: 0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.white,
                side: const BorderSide(width: 1, color: ColorsFM.green40)),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertCancel(
                  consult: state.consult,
                ),
              );
            },
            child: Text(
              Languages.of(context).cancel,
              style: TypefaceStyles.buttonPoppinsSemiBold14.copyWith(
                color: ColorsFM.green40,
              ),
            ),
          ),
        ),
      SizedBox(
        height: MediaQuery.of(context).padding.bottom,
      )
    ]);
  }

  bool validateIfAllowToRescheduleAppointment(MyConsultDetailState state) {
    try {
      if (state.consult.type == ConsultType.SCHEDULING) {
        return true;
      } else if (state.consult.type == ConsultType.REPROGRAMMING ||
          state.consult.type == ConsultType.SCHEDULE) {
        final dateConsult = DateTime.parse(state.consult.date);
        final lastDateToReschedule =
            dateConsult.subtract(const Duration(days: 2));
        final today = DateTime.now();
        if (today.isAfter(lastDateToReschedule)) {
          return false;
        } else {
          return true;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Column getListOfWidgetsPrivacy(
      BuildContext context, MyConsultDetailState state) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(marginStandard),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            state.consult.patient != null
                ? PatientDataInfo(patient: state.consult.patient!)
                : Container(),
            const OpenDialogConfirmConsult(),
          ],
        ),
      ),
      Center(
        child: Column(
          children: [
            SvgPicture.asset(iconPrivacyLarge),
            Text(
              Languages.of(context).consultPrivateByPatient,
              style: TypefaceStyles.semiBoldMontserrat
                  .copyWith(color: ColorsFM.primary80),
              textAlign: TextAlign.center,
            )
          ],
        ),
      )
    ]);
  }
}

class HeaderDetailConsult extends StatelessWidget {
  final ConsultType consultType;
  final String speciality;
  final bool private;
  final bool reschedule;
  const HeaderDetailConsult(
      {Key? key,
      required this.consultType,
      required this.speciality,
      required this.private,
      required this.reschedule})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 155,
      child: Card(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.zero,
        color: reschedule ? ColorsFM.green20 : consultType.getColorByType(),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(100))),
        child: Stack(
          children: [
            Positioned(
                bottom: minMargin,
                right: -28,
                child: SvgPicture.asset(consultType.getAssetDetailedConsult())),
            Padding(
              padding: const EdgeInsets.only(left: marginStandard, top: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(consultType.getTypeTitleDetail(context),
                      style:
                          TypefaceStyles.poppinsSemiBold12NeutralDark.copyWith(
                        fontSize: 18,
                        color: consultType.getColorByTypeOfHeader(),
                      )),
                  Text(
                    private
                        ? 'Consulta\nPrivada'
                        : '${Languages.of(context).consult}\n$speciality',
                    style: TypefaceStyles.poppinsSemiBold28
                        .copyWith(fontSize: 24, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
