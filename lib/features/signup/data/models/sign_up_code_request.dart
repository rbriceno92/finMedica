import 'package:json_annotation/json_annotation.dart';

part 'sign_up_code_request.g.dart';

@JsonSerializable()
class SignUpCodeRequest {
  @JsonKey(name: 'user_id')
  final String userId;
  final String code;

  const SignUpCodeRequest({
    required this.userId,
    required this.code,
  });

  factory SignUpCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$SignUpCodeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpCodeRequestToJson(this);
}
