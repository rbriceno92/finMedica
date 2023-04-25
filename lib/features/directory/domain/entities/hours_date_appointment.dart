import 'package:equatable/equatable.dart';

import '../../data/models/schedule_doctor.dart';

class HourDateAppointment extends Equatable {
  final String hour;
  final bool available;
  bool selected;
  final Time? time;

  HourDateAppointment(
      {required this.hour,
      required this.available,
      required this.selected,
      this.time});

  @override
  List<Object?> get props => [hour, available, selected, time];
}
