// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';

part 'resend_code_model.g.dart';

@JsonSerializable()
class ResendCodeModel {
  @JsonKey(name: 'user_id')
  final String? userId;

  const ResendCodeModel({
    required this.userId,
  });

  factory ResendCodeModel.fromJson(Map<String, dynamic> json) =>
      _$ResendCodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResendCodeModelToJson(this);
}
