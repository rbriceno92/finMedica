import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'speciality_model.g.dart';

@JsonSerializable()
class Speciality extends Equatable {
  final int id;
  final String name;

  const Speciality({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];

  factory Speciality.fromJson(Map<String, dynamic> json) =>
      _$SpecialityFromJson(json);

  Map<String, dynamic> toJson() => _$SpecialityToJson(this);
}
