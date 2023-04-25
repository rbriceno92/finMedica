import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'book_appointment_params.g.dart';

@JsonSerializable()
class BookAppointmentParams extends Equatable {
  final String type;
  final String time;
  final String date;
  final int orden;
  @JsonKey(name: 'agenda_id')
  final int agendaId;
  @JsonKey(name: 'persona_id')
  final int personaId;
  @JsonKey(name: 'speciality_id')
  final int specialityId;
  final bool privacy;

  const BookAppointmentParams(
      {required this.type,
      required this.time,
      required this.date,
      required this.orden,
      required this.agendaId,
      required this.personaId,
      required this.specialityId,
      this.privacy = false});

  @override
  List<Object?> get props =>
      [type, time, date, orden, agendaId, personaId, specialityId, privacy];

  factory BookAppointmentParams.fromJson(Map<String, dynamic> json) =>
      _$BookAppointmentParamsFromJson(json);

  Map<String, dynamic> toJson() => _$BookAppointmentParamsToJson(this);
}
