import 'package:app/features/directory/domain/entities/doctor.dart';
import 'package:app/util/models/model_user.dart';

import '../../../my_groups/domain/entities/my_groups_member.dart';

class ScheduleAppointmentsScreenParams {
  final ModelUser? user;
  final Doctor? doctor;
  final MyGroupsMember? member;
  final int? speciality;
  final bool? reschedule;
  final int? consultId;

  ScheduleAppointmentsScreenParams(
      {required this.user,
      required this.doctor,
      this.member,
      this.speciality,
      this.reschedule,
      this.consultId});
}
