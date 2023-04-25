import 'package:app/core/di/modules.dart';
import 'package:app/features/directory/data/models/schedule_appointments_screen_params.dart';
import 'package:app/features/directory/domain/entities/hours_date_appointment.dart';
import 'package:app/features/directory/presentation/bloc/schedule/schedule_bloc.dart';
import 'package:app/features/directory/presentation/bloc/schedule/schedule_event.dart';
import 'package:app/features/directory/presentation/widgets/dialog_calendar.dart';
import 'package:app/features/my_consults/domain/entities/consult.dart';
import 'package:app/features/my_consults/domain/entities/consult_type.dart';
import 'package:app/features/my_consults/domain/entities/doctor.dart';
import 'package:app/features/my_consults/domain/entities/patient.dart';
import 'package:app/features/my_groups/domain/entities/my_groups_member.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/models/model_user.dart';
import 'package:app/util/widgets/alert_notification.dart';
import 'package:app/util/widgets/input_decorator.dart';
import 'package:app/util/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../generated/l10n.dart';
import '../../../../util/assets_routes.dart';
import '../../../../util/colors_fm.dart';
import '../../../../util/dimens.dart';
import '../../../../util/fonts_types.dart';
import '../../../../util/widgets/spinner_loading.dart';
import '../bloc/schedule/schedule_state.dart';
import 'package:app/util/format_date.dart';

class ScheduleAppointmentScreen extends StatelessWidget {
  final ScheduleAppointmentsScreenParams params;
  const ScheduleAppointmentScreen({Key? key, required this.params})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ScheduleBloc>()
        ..add(GetSchedule(doctor: params.doctor?.professionalId ?? 0))
        ..add(LoadUser()),
      child: Scaffold(
        backgroundColor: ColorsFM.primaryLight99,
        appBar: AppBar(
            backgroundColor: ColorsFM.green40,
            title: Text(params.reschedule != null
                ? Languages.of(context).consultRescheduleTitle
                : Languages.of(context).scheduleAppointment)),
        body: LayoutBuilder(
          builder: (context, constraints) => ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 240,
                        child: Card(
                          clipBehavior: Clip.hardEdge,
                          margin: EdgeInsets.zero,
                          color: ColorsFM.green40,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(100))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: marginStandard, right: largeMargin),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Languages.of(context).consultDetail,
                                  style: TypefaceStyles.poppinsSemiBold28
                                      .copyWith(fontSize: 24),
                                ),
                                const SizedBox(
                                  height: smallMargin,
                                ),
                                ScheduleDoctorItem(
                                  speciality: params.doctor?.speciality ?? '',
                                  name: params.doctor?.fullName() ?? '',
                                  photo: params.doctor?.photo ?? '',
                                ),
                                const SizedBox(
                                  height: smallMargin,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: ColorsFM.primary99,
                                ),
                                DirectionScheduleItem(
                                  direction: params.doctor != null
                                      ? '${params.doctor!.location} | ${params.doctor!.address}'
                                      : '--',
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: ColorsFM.primary99,
                                ),
                                SchedulePatientItem(
                                  user: params.user ?? params.member,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: marginStandard,
                              right: marginStandard,
                              top: marginStandard),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 26,
                              ),
                              InputDateScheduleAppointment(),
                              const SizedBox(
                                height: minMargin,
                              ),
                              Text(
                                Languages.of(context).selectDateToConsult,
                                style: TypefaceStyles.poppinsRegular.copyWith(
                                    fontSize: 12, color: ColorsFM.neutralColor),
                              ),
                              const SizedBox(
                                height: marginStandard,
                              ),
                              const SelectDateWidget(),
                              const SizedBox(
                                height: marginStandard,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: marginStandard),
                          child: ButtonScheduleAppointment(params: params))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonScheduleAppointment extends StatelessWidget {
  final ScheduleAppointmentsScreenParams params;
  const ButtonScheduleAppointment({Key? key, required this.params})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScheduleBloc, ScheduleState>(
      listener: (context, state) {
        if (state.isLoading) {
          SpinnerLoading.showDialogLoading(context);
        } else if (_isThereCurrentDialogShowing(context)) {
          Navigator.pop(context);
        }
        if (state.message.isNotEmpty) {
          AlertNotification.error(context, state.message);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: marginStandard + MediaQuery.of(context).padding.bottom),
          child: ElevatedButton(
              onPressed: (state.date != null && state.hour.isNotEmpty)
                  ? () {
                      _buttonMyConsultsDetail(state, context);
                    }
                  : null,
              child: Text(Languages.of(context).continueText)),
        );
      },
    );
  }

  _buttonMyConsultsDetail(ScheduleState state, BuildContext context) {
    Navigator.of(context).pushNamed(myConsultsDetailRoute,
        arguments: Consult(
            consultId: params.consultId,
            reschedule: params.reschedule,
            type: ConsultType.SCHEDULING,
            speciality: params.doctor?.speciality,
            date: state.date?.toIso8601String() ?? '',
            direction: params.doctor?.address,
            doctor: Doctor(
                name: params.doctor?.fullName() ?? '',
                professionalId: params.speciality ?? 1,
                photo: params.doctor?.photo),
            patient: Patient(
              personId: params.user?.idUserAlephoo ?? 1,
              name: params.user?.fullName() ?? '',
              gender: params.user?.getGender(context) ?? '',
              age: params.user?.age ?? 0,
            ),
            created_by: state.user!.fullName(),
            recreated_by: null,
            expired_date: null,
            private: false,
            tokens_consumed: null,
            tokens_available: null,
            motive: null,
            reason: null,
            payment: null,
            main_user: (params.user is MyGroupsMember) ? false : true,
            timeConsult: state.time));
  }

  _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;
}

class ScheduleDoctorItem extends StatelessWidget {
  final String speciality;
  final String name;
  final String photo;

  const ScheduleDoctorItem(
      {Key? key,
      required this.speciality,
      required this.name,
      required this.photo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Container(
                width: 55,
                height: 55,
                color: ColorsFM.green95,
                child: photo.isEmpty
                    ? SvgPicture.asset(
                        iconDoctor41,
                        fit: BoxFit.scaleDown,
                        height: 41,
                        width: 41,
                        clipBehavior: Clip.none,
                      )
                    : Image.memory(
                        photo.decodeBase64(),
                        gaplessPlayback: true,
                      ))),
        Padding(
          padding: const EdgeInsets.all(extraSmallMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TypefaceStyles.poppinsSemiBold14Primary
                    .copyWith(color: Colors.white),
              ),
              const SizedBox(
                height: 2,
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                speciality,
                style: TypefaceStyles.poppinsRegularPrimary
                    .copyWith(color: Colors.white),
              )
            ],
          ),
        )
      ],
    );
  }
}

class DirectionScheduleItem extends StatelessWidget {
  final String direction;
  const DirectionScheduleItem({Key? key, required this.direction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconHospital2,
              color: Colors.white,
              height: 18,
              width: 18,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(extraSmallMargin),
                child: Text(
                  direction,
                  style: TypefaceStyles.poppinsSemiBold14Primary
                      .copyWith(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

class SchedulePatientItem extends StatelessWidget {
  final ModelUser? user;
  const SchedulePatientItem({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: smallMargin),
          child: SvgPicture.asset(
            user?.isGroup() ?? true ? iconGroupSmall : iconUsers,
            color: Colors.white,
            width: 18,
            height: 18,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(extraSmallMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Languages.of(context).patient,
                  style: TypefaceStyles.poppinsSemiBold14Primary
                      .copyWith(color: Colors.white),
                ),
                Text(
                  user?.isGroup() ?? true
                      ? Languages.of(context).patientGroupInfoScheduleText(
                          '${user?.firstName} ${user?.lastName}',
                          user?.getGender(context) ?? '',
                          user?.age ?? 0)
                      : Languages.of(context).patientUserInfoScheduleText(
                          '${user?.firstName} ${user?.lastName}',
                          user?.getGender(context) ?? '',
                          user?.age ?? 0),
                  style: TypefaceStyles.poppinsRegularPrimary
                      .copyWith(color: Colors.white),
                )
              ],
            ),
          ),
        ),
        user?.isGroup() ?? true
            ? Padding(
                padding: const EdgeInsets.only(top: smallMargin),
                child: GestureDetector(
                    onTap: () {
                      Navigator.popUntil(
                          context, ModalRoute.withName(myGroupsRoute));
                    },
                    child: SvgPicture.asset(
                      iconPencil,
                      color: Colors.white,
                      alignment: Alignment.centerRight,
                    )),
              )
            : Container()
      ],
    );
  }
}

class InputDateScheduleAppointment extends StatefulWidget {
  InputDateScheduleAppointment({Key? key}) : super(key: key);
  var dateState = DateTime.now();
  @override
  State<InputDateScheduleAppointment> createState() =>
      _InputDateScheduleAppointmentState();
}

class _InputDateScheduleAppointmentState
    extends State<InputDateScheduleAppointment> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScheduleBloc, ScheduleState>(
      listener: (context, state) {},
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            widget.dateState = state.date ?? DateTime.now();
            openDialogDatePicker(context, state);
          },
          child: TextFormField(
            controller: TextEditingController(
                text: state.date?.dateFormat() ?? 'DD/MM/AAAA'),
            style: TypefaceStyles.bodyMediumMontserrat.copyWith(fontSize: 16),
            decoration: InputScheduleAppointmentDecorator
                .getInputDecoratorScheduleAppointment(
                    Languages.of(context).selectDate),
            enabled: false,
          ),
        );
      },
    );
  }

  void openDialogDatePicker(BuildContext contextGeneral, ScheduleState state) {
    var today = DateTime.now();
    var start = DateTime(today.year, today.month, today.day);
    var end = DateTime(today.year, today.month + 2, 1);
    showDialog(
        context: contextGeneral,
        builder: (context) {
          return DialogCalendar(
            contextGeneral: contextGeneral,
            start: start,
            end: end,
            availableDates: state.schedule?.availableDates,
          );
        });
  }
}

class SelectDateWidget extends StatefulWidget {
  const SelectDateWidget({Key? key}) : super(key: key);

  @override
  State<SelectDateWidget> createState() => _SelectDateWidgetState();
}

class _SelectDateWidgetState extends State<SelectDateWidget> {
  final hoursAvailable = <HourDateAppointment>[
    HourDateAppointment(hour: '07:00', available: false, selected: false),
    HourDateAppointment(hour: '08:00', available: false, selected: false),
    HourDateAppointment(hour: '09:00', available: false, selected: false),
    HourDateAppointment(hour: '10:00', available: false, selected: false),
    HourDateAppointment(hour: '11:00', available: false, selected: false),
    HourDateAppointment(hour: '12:00', available: false, selected: false),
    HourDateAppointment(hour: '13:00', available: false, selected: false),
    HourDateAppointment(hour: '14:00', available: false, selected: false),
    HourDateAppointment(hour: '15:00', available: false, selected: false),
    HourDateAppointment(hour: '16:00', available: false, selected: false),
    HourDateAppointment(hour: '17:00', available: false, selected: false),
    HourDateAppointment(hour: '17:00', available: false, selected: false),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScheduleBloc, ScheduleState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 200,
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              decoration: BoxDecoration(
                border: Border.all(color: ColorsFM.neutralColor, width: 1),
                borderRadius: BorderRadius.circular(5),
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: GridView.count(
                  childAspectRatio: 1.7,
                  padding: EdgeInsets.zero,
                  crossAxisCount: 4,
                  children: List.generate(
                      state.listTimes?.length ?? hoursAvailable.length,
                      (index) {
                    return ChipHour(
                        hourDateAppointment:
                            state.listTimes?[index] ?? hoursAvailable[index],
                        notifyParent: () {
                          setState(() {
                            for (var element
                                in state.listTimes ?? hoursAvailable) {
                              if (element !=
                                  (state.listTimes?[index] ??
                                      hoursAvailable[index])) {
                                element.selected = false;
                              }
                            }
                          });
                        });
                  }),
                ),
              ),
            ),
            Positioned(
              left: 8,
              top: 12,
              child: Container(
                color: ColorsFM.primaryLight99,
                padding: const EdgeInsets.symmetric(horizontal: minMargin),
                child: Text(
                  textAlign: TextAlign.center,
                  Languages.of(context).selectHour,
                  style: TypefaceStyles.poppinsRegular,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ChipHour extends StatefulWidget {
  final HourDateAppointment hourDateAppointment;
  final Function() notifyParent;

  const ChipHour(
      {Key? key, required this.hourDateAppointment, required this.notifyParent})
      : super(key: key);

  @override
  State<ChipHour> createState() => _ChipHourState();
}

class _ChipHourState extends State<ChipHour> {
  @override
  Widget build(BuildContext context) {
    return FilterChip(
        padding:
            const EdgeInsets.symmetric(horizontal: smallMargin, vertical: 12),
        label: Text(widget.hourDateAppointment.hour),
        disabledColor: widget.hourDateAppointment.available
            ? ColorsFM.green95
            : ColorsFM.neutralColor,
        labelStyle: TypefaceStyles.poppinsRegular.copyWith(
            color: getColor(widget.hourDateAppointment.available,
                widget.hourDateAppointment.selected)),
        selectedColor: widget.hourDateAppointment.selected
            ? ColorsFM.green40
            : ColorsFM.green95,
        selected: widget.hourDateAppointment.available,
        backgroundColor: ColorsFM.neutral99,
        showCheckmark: false,
        onSelected: (bool value) {
          if (widget.hourDateAppointment.available) {
            widget.hourDateAppointment.selected =
                !widget.hourDateAppointment.selected;
            if (widget.hourDateAppointment.selected) {
              context.read<ScheduleBloc>().add(SetHour(
                  hour: widget.hourDateAppointment.hour,
                  time: widget.hourDateAppointment.time));
            } else {
              context
                  .read<ScheduleBloc>()
                  .add(const SetHour(hour: '', time: null));
            }
            setState(() {});
            widget.notifyParent();
          }
        });
  }

  Color getColor(bool available, bool selected) {
    if (available && selected) {
      return Colors.white;
    } else if (available && !selected) {
      return ColorsFM.green40;
    } else {
      return ColorsFM.neutralColor;
    }
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
