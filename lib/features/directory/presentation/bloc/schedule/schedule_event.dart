import 'package:app/features/directory/data/models/schedule_doctor.dart';
import 'package:equatable/equatable.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();
}

class GetSchedule extends ScheduleEvent {
  final int doctor;

  const GetSchedule({required this.doctor});

  @override
  List<Object?> get props => [doctor];
}

class SetDate extends ScheduleEvent {
  final DateTime date;

  const SetDate({required this.date});

  @override
  List<Object?> get props => [date];
}

class SetHour extends ScheduleEvent {
  final String hour;
  final Time? time;

  const SetHour({required this.hour, this.time});

  @override
  List<Object?> get props => [hour, time];
}

class LoadUser extends ScheduleEvent {
  @override
  List<Object?> get props => [];
}
