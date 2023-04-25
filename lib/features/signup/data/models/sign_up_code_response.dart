import 'package:json_annotation/json_annotation.dart';

part 'sign_up_code_response.g.dart';

@JsonSerializable()
class SignUpCodeResponse {
  @JsonKey(name: 'Message')
  final String message;
  final String token;

  SignUpCodeResponse({required this.message, required this.token});

  factory SignUpCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpCodeResponseToJson(this);
}
