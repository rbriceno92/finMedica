import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'send_email_model.g.dart';

@JsonSerializable()
class SendEmailModel extends Equatable {
  final String email;
  @JsonKey(name: 'validate_code')
  final bool validateCode;
  final String? code;

  const SendEmailModel(
      {required this.email, required this.validateCode, this.code});

  @override
  List<Object?> get props => [email, validateCode, code];

  factory SendEmailModel.fromJson(Map<String, dynamic> json) =>
      _$SendEmailModelFromJson(json);

  Map<String, dynamic> toJson() => _$SendEmailModelToJson(this);
}
