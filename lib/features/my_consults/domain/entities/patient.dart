import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patient.g.dart';

@JsonSerializable()
class Patient extends Equatable {
  @JsonKey(name: 'person_id')
  final int personId;
  final String name;
  final String gender;
  final int age;

  const Patient({
    required this.personId,
    required this.name,
    required this.gender,
    required this.age,
  });

  @override
  List<Object?> get props => [
        name,
        gender,
        age,
      ];

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);
}
