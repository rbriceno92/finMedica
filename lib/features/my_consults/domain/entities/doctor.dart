import 'package:json_annotation/json_annotation.dart';

part 'doctor.g.dart';

@JsonSerializable()
class Doctor {
  final String name;
  @JsonKey(name: 'specialist_id')
  final int professionalId;
  late String? photo;
  final int? personaId;

  Doctor(
      {required this.name,
      required this.professionalId,
      this.photo,
      this.personaId});

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);
}
