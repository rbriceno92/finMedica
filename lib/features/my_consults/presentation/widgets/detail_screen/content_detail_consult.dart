import 'package:app/features/my_consults/domain/entities/consult.dart';
import 'package:app/features/my_consults/domain/entities/consult_type.dart';
import 'package:app/features/my_consults/domain/entities/doctor.dart';
import 'package:app/features/my_consults/domain/entities/patient.dart';
import 'package:app/features/my_consults/presentation/bloc/my_consult_detail_bloc.dart';
import 'package:app/features/my_consults/presentation/bloc/my_consult_detail_event.dart';
import 'package:app/features/my_consults/presentation/bloc/my_consult_detail_state.dart';
import 'package:app/features/my_consults/presentation/widgets/detail_screen/information_alert_expired.dart';
import 'package:app/features/terms_conditions/presentation/view/terms_conditions_screen.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/assets_routes.dart';
import 'package:app/util/dimens.dart';
import 'package:app/util/fonts_types.dart';
import 'package:app/util/format_date.dart';
import 'package:app/util/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../util/colors_fm.dart';
import '../open_dialog/open_dialog_confirm_consult.dart';

class BodyDetailConsult extends StatelessWidget {
  final Consult consult;
  const BodyDetailConsult({Key? key, required this.consult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyConsultDetailBloc, MyConsultDetailState>(
      listener: (context, state) {},
      builder: (context, state) => Padding(
        padding: const EdgeInsets.all(marginStandard),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            consult.doctor != null
                ? DoctorInfo(doctor: consult.doctor!, type: consult.type)
                : Container(),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                consult.patient != null
                    ? PatientDataInfo(patient: consult.patient!)
                    : Container(),
                consult.speciality != null &&
                        consult.speciality !=
                            Languages.of(context).consultNotApplied
                    ? Flexible(
                        child: DataTitleValueInfo(
                        title: Languages.of(context).speciality,
                        value: consult.speciality!,
                      ))
                    : Container(),
                const SizedBox(
                  width: largeMargin,
                )
              ],
            ),
            DataTitleValueInfo(
                title: consult.speciality !=
                        Languages.of(context).consultNotApplied
                    ? consult.type.getDateTitleByType(context)
                    : Languages.of(context).activateDate,
                value: consult.date.consultsDateFormat()),
            (consult.observacion != null)
                ? DataTitleValueInfo(
                    title: Languages.of(context).motive,
                    value: consult.observacion ?? '')
                : Container(),
            consult.direction != null
                ? DataTitleValueInfo(
                    title: Languages.of(context).direction,
                    value: consult.direction!)
                : Container(),
            consult.expired_date != null
                ? DataTitleValueInfo(
                    title: Languages.of(context).dateExpired,
                    value: consult.expired_date!.consultsDateFormat())
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                consult.created_by != null
                    ? Flexible(
                        child: DataTitleValueInfo(
                            title: consult.type.getTextDateCreatedBy(context),
                            value: consult.created_by ?? ''),
                      )
                    : Container(),
                (consult.type == ConsultType.CANCELED &&
                        consult.canceledBy.isNotEmpty)
                    ? Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(right: mediumMargin),
                          child: DataTitleValueInfo(
                              title: consult.type
                                  .getTextDateChangedByType(context),
                              value: consult.canceledBy),
                        ),
                      )
                    : Container(),
              ],
            ),
            if (consult.type == ConsultType.SCHEDULE ||
                consult.type == ConsultType.REPROGRAMMING ||
                consult.type == ConsultType.COMPLETED)
              Padding(
                  padding: const EdgeInsets.only(top: smallMargin),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, termsConditionsRoote,
                          arguments: TCScreenArgs(
                              from: TCScreenFrom.dashboard,
                              acceptedTerms:
                                  state.user?.termsConditions ?? true));
                    },
                    child: Text(
                      Languages.of(context).seeTermsAndConditions,
                      style: TypefaceStyles.bodySmallMontserrat12.copyWith(
                          color: ColorsFM.green40, fontWeight: FontWeight.w600),
                    ),
                  )),
            TokenWidget(consult: consult),
            ((consult.type == ConsultType.EXPIRED ||
                        consult.type == ConsultType.NOT_ASSIST) &&
                    consult.reason != null)
                ? InformationAlertExpired(reason: consult.reason!)
                : Container(),
          ],
        ),
      ),
    );
  }
}

class DoctorInfo extends StatelessWidget {
  final Doctor doctor;
  final ConsultType type;
  const DoctorInfo({Key? key, required this.doctor, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Languages.of(context).doctor,
          style: TypefaceStyles.semiBoldMontserrat,
        ),
        const SizedBox(
          height: smallMargin,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Container(
                        width: 40,
                        height: 40,
                        color: type.getDoctorBackgroungColorByType(), //here
                        child: doctor.photo == null || doctor.photo!.isEmpty
                            ? SvgPicture.asset(
                                iconDoctorConsultDetail,
                                color: type.getDoctorUserLogoColorByType(),
                                width: 2,
                                height: 2,
                                fit: BoxFit.scaleDown,
                                clipBehavior: Clip.none,
                              )
                            : Image.memory(
                                doctor.photo!.decodeBase64(),
                                gaplessPlayback: true,
                              ))),
                const SizedBox(
                  width: smallMargin,
                ),
                Text(
                  doctor.name,
                  style: TypefaceStyles.bodyMediumMontserrat,
                )
              ],
            ),
            const OpenDialogConfirmConsult(),
          ],
        ),
        const SizedBox(
          height: smallMargin,
        ),
      ],
    );
  }
}

class PatientDataInfo extends StatelessWidget {
  final Patient patient;
  const PatientDataInfo({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Languages.of(context).patient,
            style: TypefaceStyles.semiBoldMontserrat,
          ),
          const SizedBox(
            height: smallMargin,
          ),
          Text(
            patient.name,
            overflow: TextOverflow.ellipsis,
            style: TypefaceStyles.semiBoldMontserrat.copyWith(fontSize: 13),
          ),
          Text(
            '${patient.age} ${Languages.of(context).years}',
            style: TypefaceStyles.bodyMediumMontserrat,
          ),
          const SizedBox(
            height: smallMargin,
          ),
        ],
      ),
    );
  }

  String getGender(String gender, BuildContext context) {
    if (gender == 'f') {
      return Languages.of(context).female;
    } else {
      return Languages.of(context).male;
    }
  }
}

class DataTitleValueInfo extends StatelessWidget {
  final String title;
  final String value;

  const DataTitleValueInfo({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: smallMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            style: TypefaceStyles.semiBoldMontserrat,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: smallMargin,
          ),
          Text(
            value,
            style: TypefaceStyles.montserrat8
                .copyWith(fontSize: 12.50, color: ColorsFM.neutralDark),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class TokenWidget extends StatelessWidget {
  final Consult consult;
  const TokenWidget({Key? key, required this.consult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        consult.tokens_consumed != null
            ? DataTitleValueInfo(
                title: Languages.of(context).tokensUsed,
                value: '${consult.tokens_consumed} Bonos')
            : Container(),
        consult.tokens_available != null
            ? DataTitleValueInfo(
                title: Languages.of(context).tokensNotUsed,
                value: '${consult.tokens_available} Bonos')
            : Container(),
      ],
    );
  }
}

class CheckboxSection extends StatelessWidget {
  final bool mainUser;
  const CheckboxSection({Key? key, required this.mainUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyConsultDetailBloc, MyConsultDetailState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                      hoverColor: ColorsFM.green40,
                      activeColor: ColorsFM.green40,
                      value: state.acceptConditions,
                      onChanged: (value) {
                        context
                            .read<MyConsultDetailBloc>()
                            .add(AcceptConsultTerms());
                      }),
                ),
                const SizedBox(
                  width: marginStandard,
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    context
                        .read<MyConsultDetailBloc>()
                        .add(AcceptConsultTerms());
                  },
                  child: Text(
                    Languages.of(context).termsSchedule,
                    style: TypefaceStyles.bodyMediumMontserrat,
                  ),
                ))
              ],
            ),
            Row(
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Theme(
                    data: ThemeData(
                        unselectedWidgetColor:
                            !mainUser ? ColorsFM.neutral95 : ColorsFM.green40),
                    child: Checkbox(
                        hoverColor: ColorsFM.green40,
                        activeColor: ColorsFM.green40,
                        value: !mainUser ? false : state.isPrivate,
                        onChanged: (value) {
                          if (mainUser) {
                            context
                                .read<MyConsultDetailBloc>()
                                .add(MakeConsultPrivate());
                          }
                        }),
                  ),
                ),
                const SizedBox(
                  width: marginStandard,
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    context
                        .read<MyConsultDetailBloc>()
                        .add(MakeConsultPrivate());
                  },
                  child: Text(
                    Languages.of(context).makeThisSchedulePrivate,
                    style: TypefaceStyles.bodyMediumMontserrat.copyWith(
                        color: !mainUser
                            ? ColorsFM.neutralColor
                            : ColorsFM.neutralDark),
                  ),
                ))
              ],
            )
          ],
        );
      },
    );
  }
}
