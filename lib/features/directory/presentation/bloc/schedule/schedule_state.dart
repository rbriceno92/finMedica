import 'package:app/features/directory/data/models/schedule_doctor.dart';
import 'package:app/util/models/model_user.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/hours_date_appointment.dart';

class ScheduleState extends Equatable {
  final DateTime? date;
  final bool isLoading;
  final String hour;
  final ModelUser? user;
  final Time? time;
  final ScheduleDoctor? schedule;
  List<HourDateAppointment>? listTimes = <HourDateAppointment>[
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
    HourDateAppointment(hour: '18:00', available: false, selected: false),
  ];
  final String message;

  ScheduleState(
      {this.date,
      this.hour = '',
      this.user,
      this.schedule,
      this.listTimes,
      this.time,
      this.isLoading = false,
      this.message = ''});

  ScheduleState copyWith({
    DateTime? date,
    String? hour,
    ModelUser? user,
    ScheduleDoctor? schedule,
    List<HourDateAppointment>? listTimes,
    Time? time,
    bool? isLoading,
    String? message,
  }) {
    return ScheduleState(
        date: date ?? this.date,
        hour: hour ?? this.hour,
        user: user ?? this.user,
        schedule: schedule ?? this.schedule,
        listTimes: listTimes ?? this.listTimes,
        time: time ?? this.time,
        isLoading: isLoading ?? false,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props =>
      [date, hour, user, schedule, listTimes, time, isLoading, message];
}
