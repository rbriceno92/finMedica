import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'reschedule_appointment_param.g.dart';

@JsonSerializable()
class RescheduleAppointmentParam extends Equatable {
  final int consultId;
  final String newDate;
  final String newTime;

  const RescheduleAppointmentParam(
      {required this.consultId, required this.newDate, required this.newTime});

  @override
  List<Object?> get props => [consultId, newDate, newTime];

  factory RescheduleAppointmentParam.fromJson(Map<String, dynamic> json) =>
      _$RescheduleAppointmentParamFromJson(json);

  Map<String, dynamic> toJson() => _$RescheduleAppointmentParamToJson(this);
}
