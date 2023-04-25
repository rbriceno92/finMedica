import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'schedule_doctor.g.dart';

@JsonSerializable()
class ScheduleDoctor extends Equatable {
  @JsonKey(name: 'available_dates')
  final List<DatesAvailable> availableDates;
  @JsonKey(name: 'earliest_date')
  final EarliestDate earliestDate;

  const ScheduleDoctor(
      {required this.availableDates, required this.earliestDate});

  @override
  List<Object?> get props => [availableDates, earliestDate];

  factory ScheduleDoctor.fromJson(Map<String, dynamic> json) =>
      _$ScheduleDoctorFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleDoctorToJson(this);
}

@JsonSerializable()
class DatesAvailable extends Equatable {
  final String date;
  final List<Time> times;

  const DatesAvailable({required this.date, required this.times});

  @override
  List<Object?> get props => [date, times];

  factory DatesAvailable.fromJson(Map<String, dynamic> json) =>
      _$DatesAvailableFromJson(json);

  Map<String, dynamic> toJson() => _$DatesAvailableToJson(this);
}

@JsonSerializable()
class Time extends Equatable {
  final String time;
  final String type;
  @JsonKey(name: 'orden')
  final int orden;
  @JsonKey(name: 'agenda')
  final int schedule;
  @JsonKey(name: 'especialidad')
  final int speciality;

  const Time(
      {required this.time,
      required this.type,
      required this.orden,
      required this.schedule,
      required this.speciality});

  @override
  List<Object?> get props => [time, type, orden, schedule, speciality];

  factory Time.fromJson(Map<String, dynamic> json) => _$TimeFromJson(json);

  Map<String, dynamic> toJson() => _$TimeToJson(this);
}

@JsonSerializable()
class EarliestDate extends Equatable {
  final String date;
  final String time;
  final int orden;
  final int agenda;
  final String type;
  @JsonKey(name: 'especialidad')
  final int speciality;

  const EarliestDate(
      {required this.date,
      required this.time,
      required this.orden,
      required this.agenda,
      required this.type,
      required this.speciality});

  @override
  List<Object?> get props => [date, time, orden, agenda, type, speciality];

  factory EarliestDate.fromJson(Map<String, dynamic> json) =>
      _$EarliestDateFromJson(json);

  Map<String, dynamic> toJson() => _$EarliestDateToJson(this);
}
