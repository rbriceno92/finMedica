import 'package:app/features/my_consults/domain/entities/consult.dart';
import 'package:app/features/my_consults/domain/entities/patient.dart';
import 'package:app/features/my_consults/domain/entities/reason.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/consult_type.dart';
import '../../domain/entities/doctor.dart';

part 'consult_model.g.dart';

@JsonSerializable()
class ConsultModel extends Equatable {
  final String patientName;
  @JsonKey(name: 'patientLastname')
  final String patientLastName;
  final String doctorName;
  @JsonKey(name: 'doctorLastname')
  final String doctorLastName;
  final String date;
  final String time;
  final String speciality;
  final String institution;
  @JsonKey(name: 'state')
  final ConsultType type;
  @JsonKey(name: 'privacy')
  final bool? private;
  final String? patientAge;
  final String? institutionAddress;
  final String? consultCreatorName;
  final String? patientGender;
  final int? consultId;
  final int professionalId;
  final String? observacion;
  final String? consultCanceledBy;
  final CancelMessage? cancelMessage;
  final int? profesionalPersonaId;
  final String? prefix;
  final bool? cancelationWasRefunded;

  const ConsultModel({
    required this.patientName,
    required this.type,
    this.private,
    required this.patientLastName,
    required this.date,
    required this.doctorName,
    required this.doctorLastName,
    required this.time,
    required this.speciality,
    required this.institution,
    this.patientAge,
    this.consultCreatorName,
    this.institutionAddress,
    this.patientGender,
    required this.professionalId,
    this.observacion,
    this.consultId,
    this.consultCanceledBy = '',
    this.cancelMessage,
    this.profesionalPersonaId,
    this.prefix,
    this.cancelationWasRefunded,
  });

  Consult toEntity() => Consult(
      doctorLastName: doctorLastName,
      doctorName: doctorName,
      patient: Patient(
          age: int.parse(patientAge ?? '0'),
          name: '$patientName $patientLastName',
          gender: patientGender ?? 'f',
          personId: 0),
      type: type,
      date: '$date $time',
      dateNextConsult: date,
      timeNextConsult: time,
      doctor: Doctor(
          name:
              '${prefix != null && prefix!.isNotEmpty ? '$prefix ' : ''}$doctorName $doctorLastName',
          professionalId: professionalId,
          personaId: profesionalPersonaId),
      speciality: speciality,
      institution: institution,
      direction: institutionAddress,
      private: private ?? false,
      consultId: consultId,
      created_by: consultCreatorName,
      observacion: observacion,
      canceledBy: consultCanceledBy ?? '',
      reason: Reason(
          title: cancelMessage?.title ?? '',
          description: cancelMessage?.body ?? '',
          refund: cancelationWasRefunded ?? false));

  factory ConsultModel.fromJson(Map<String, dynamic> json) =>
      _$ConsultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConsultModelToJson(this);

  @override
  List<Object?> get props => [
        patientLastName,
        patientName,
        date,
        doctorName,
        doctorLastName,
        time,
        speciality,
        institution,
        type,
        private,
        patientAge,
        institutionAddress,
        consultCreatorName,
        patientGender,
        consultId,
        professionalId,
        observacion,
        consultCanceledBy,
        cancelMessage,
        profesionalPersonaId,
        prefix,
        cancelationWasRefunded,
      ];
}

@JsonSerializable()
class CancelMessage extends Equatable {
  final String title;
  final String body;

  const CancelMessage({required this.title, required this.body});

  @override
  List<Object?> get props => [title, body];

  factory CancelMessage.fromJson(Map<String, dynamic> json) =>
      _$CancelMessageFromJson(json);

  Map<String, dynamic> toJson() => _$CancelMessageToJson(this);
}
