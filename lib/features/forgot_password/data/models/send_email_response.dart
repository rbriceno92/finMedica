import 'package:app/features/forgot_password/data/models/user_name_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'send_email_response.g.dart';

@JsonSerializable()
class SendEmailResponse extends Equatable {
  @JsonKey(name: 'Message')
  final String message;
  final UserNameModel user;

  const SendEmailResponse({required this.message, required this.user});

  factory SendEmailResponse.fromJson(Map<String, dynamic> json) =>
      _$SendEmailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendEmailResponseToJson(this);

  @override
  List<Object?> get props => [message, user];
}
