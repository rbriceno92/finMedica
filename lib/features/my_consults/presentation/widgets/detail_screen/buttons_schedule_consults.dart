import 'package:app/features/directory/domain/entities/doctor.dart';
import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../navigation/routes_names.dart';
import '../../../../../util/colors_fm.dart';
import '../../../../../util/dimens.dart';
import '../../../../../util/fonts_types.dart';
import '../../../../directory/data/models/schedule_appointments_screen_params.dart';
import '../../../domain/entities/consult.dart';
import 'cancel_alert_consult.dart';

class ButtonsMyConsult extends StatelessWidget {
  final Consult consult;
  final dynamic user;
  const ButtonsMyConsult(
      {super.key, required this.consult, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(marginStandard),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 0),
              onPressed: () {
                var doctor = Doctor(
                  name: consult.doctor?.name ?? '',
                  professionalId: consult.doctor!.professionalId,
                  speciality: consult.speciality,
                  address: consult.direction,
                  location: consult.institution,
                  specialityId: null,
                  photo: consult.doctor?.photo ?? '',
                );
                Navigator.of(context).pushNamed(scheduleAppointmentRoute,
                    arguments: ScheduleAppointmentsScreenParams(
                        user: user,
                        doctor: doctor,
                        speciality: 0,
                        reschedule: true,
                        consultId: consult.consultId));
              },
              child: Text(
                Languages.of(context).toSchedule,
                style: TypefaceStyles.buttonPoppinsSemiBold14.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: marginStandard,
          ),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  side: const BorderSide(width: 1, color: ColorsFM.green40)),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertCancel(
                    consult: consult,
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
          )
        ],
      ),
    );
  }
}
