import 'package:app/features/directory/data/models/schedule_appointments_screen_params.dart';
import 'package:app/features/directory/domain/entities/doctor.dart';
import 'package:app/features/directory/presentation/widgets/doctor_info.dart';
import 'package:app/features/directory/presentation/widgets/schedule_date.dart';
import 'package:app/navigation/routes_names.dart';
import 'package:app/util/models/model_user.dart';
import 'package:flutter/material.dart';

import '../../../../util/dimens.dart';

class SpecialistInfo extends StatelessWidget {
  final Doctor? doctor;
  final int position;
  final ModelUser? user;
  final int specialistId;
  const SpecialistInfo(
      {required this.doctor,
      required this.position,
      Key? key,
      required this.user,
      required this.specialistId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: minMargin),
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusRoundedButton),
              topRight: Radius.circular(cornerRounded),
              bottomRight: Radius.circular(cornerRounded),
              bottomLeft: Radius.circular(cornerRounded))),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: IntrinsicWidth(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DoctorInfoDirectory(doctor: doctor),
                ],
              ),
            ),
          ),
          ScheduleDate(onTap: () {
            Navigator.of(context).pushNamed(scheduleAppointmentRoute,
                arguments: ScheduleAppointmentsScreenParams(
                    user: user, doctor: doctor, speciality: specialistId));
          })
        ],
      ),
    );
  }

  String getPhone(String phone) {
    return phone.isEmpty ? '--' : phone;
  }
}
