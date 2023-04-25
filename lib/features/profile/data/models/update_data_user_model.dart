// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';

part 'update_data_user_model.g.dart';

@JsonSerializable()
class UpdateDataUserModel {
  @JsonKey(name: 'phone_number')
  final String? phone;

  const UpdateDataUserModel({
    required this.phone,
  });

  factory UpdateDataUserModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateDataUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateDataUserModelToJson(this);
}
