import 'package:app/features/directory/data/models/schedule_doctor.dart';
import 'package:app/features/my_consults/domain/entities/consult_type.dart';
import 'package:app/features/my_consults/domain/entities/payment.dart';
import 'package:equatable/equatable.dart';

import 'doctor.dart';
import 'patient.dart';
import 'reason.dart';

class Consult extends Equatable {
  final bool? reschedule;
  final String? doctorName;
  final ConsultType type;
  final int? consultId;
  final String? speciality;
  final String date;
  final String? direction;
  final Doctor? doctor;
  final Patient? patient;
  final String? motive;
  final Reason? reason;
  final Payment? payment;
  final String? created_by;
  final String? recreated_by;
  final String? expired_date;
  final int? tokens_consumed;
  final int? tokens_available;
  final bool? main_user;
  final bool private;
  final Time? timeConsult;
  final String? dateNextConsult;
  final String? timeNextConsult;
  final String? doctorLastName;
  final String? institution;
  final String? observacion;
  final String canceledBy;

  const Consult(
      {required this.type,
      this.speciality,
      required this.date,
      this.direction,
      this.doctor,
      this.patient,
      this.motive,
      this.reason,
      this.payment,
      this.created_by,
      this.recreated_by,
      this.expired_date,
      required this.private,
      this.tokens_consumed,
      this.tokens_available,
      this.main_user = true,
      this.consultId,
      this.dateNextConsult,
      this.timeNextConsult,
      this.doctorName,
      this.doctorLastName,
      this.institution,
      this.observacion,
      this.reschedule,
      this.timeConsult,
      this.canceledBy = ''});

  Consult copyWith(
          {ConsultType? type,
          int? consultId,
          String? speciality,
          String? date,
          String? direction,
          Doctor? doctor,
          Patient? patient,
          String? motive,
          Reason? reason,
          Payment? payment,
          String? created_by,
          String? recreated_by,
          String? expired_date,
          int? tokens_consumed,
          int? tokens_available,
          bool? main_user,
          bool? private,
          String? dateNextConsult,
          String? timeNextConsult,
          String? doctorName,
          String? doctorLastName,
          String? institution,
          String? observacion,
          bool? reschedule,
          String? canceledBy}) =>
      Consult(
          type: type ?? this.type,
          consultId: consultId ?? this.consultId,
          speciality: speciality ?? this.speciality,
          date: date ?? this.date,
          direction: direction ?? this.direction,
          doctor: doctor ?? this.doctor,
          patient: patient ?? this.patient,
          motive: motive ?? this.motive,
          reason: reason ?? this.reason,
          payment: payment ?? this.payment,
          created_by: created_by ?? this.created_by,
          recreated_by: recreated_by ?? this.recreated_by,
          expired_date: expired_date ?? this.expired_date,
          tokens_consumed: tokens_consumed ?? this.tokens_consumed,
          tokens_available: tokens_available ?? this.tokens_available,
          main_user: main_user ?? this.main_user,
          private: private ?? this.private,
          dateNextConsult: dateNextConsult ?? this.dateNextConsult,
          timeNextConsult: timeNextConsult ?? this.timeNextConsult,
          doctorName: doctorName ?? this.doctorName,
          doctorLastName: doctorLastName ?? this.doctorLastName,
          institution: institution ?? this.institution,
          observacion: observacion ?? this.observacion,
          reschedule: reschedule ?? this.reschedule,
          canceledBy: canceledBy ?? this.canceledBy);

  @override
  List<Object?> get props => [
        type,
        speciality,
        date,
        direction,
        doctor,
        patient,
        motive,
        reason,
        payment,
        created_by,
        recreated_by,
        expired_date,
        private,
        main_user,
        consultId,
        timeConsult,
        dateNextConsult,
        timeNextConsult,
        doctorName,
        doctorLastName,
        institution,
        observacion,
        reschedule,
        canceledBy
      ];

  bool isReasonEmpty() {
    if (reason != null &&
        reason!.title.isNotEmpty &&
        reason!.description.isNotEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
