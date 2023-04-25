import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'clinic_model.g.dart';

@JsonSerializable()
class ClinicModel extends Equatable {
  @JsonKey(name: 'alephoo_id')
  final int alephooId;
  final String name;
  final String address;
  final String phone;

  const ClinicModel(
      {required this.alephooId,
      required this.name,
      required this.address,
      required this.phone});

  @override
  List<Object?> get props => [alephooId, name, address, phone];

  factory ClinicModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClinicModelToJson(this);
}
