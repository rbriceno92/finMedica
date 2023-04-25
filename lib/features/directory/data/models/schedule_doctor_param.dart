import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'schedule_doctor_param.g.dart';

@JsonSerializable()
class ScheduleDoctorParam extends Equatable {
  final int professional_id;
  final String date;
  @JsonKey(name: 'end_date')
  final String endDate;

  const ScheduleDoctorParam(
      {required this.professional_id,
      required this.date,
      required this.endDate});

  @override
  List<Object?> get props => [professional_id, date, endDate];

  factory ScheduleDoctorParam.fromJson(Map<String, dynamic> json) =>
      _$ScheduleDoctorParamFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleDoctorParamToJson(this);
}
