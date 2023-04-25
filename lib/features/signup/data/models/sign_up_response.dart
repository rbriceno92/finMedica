import 'package:app/util/models/message_model.dart';
import 'package:app/util/models/model_user.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_up_response.g.dart';

@JsonSerializable()
class SignUpResponse extends Equatable {
  final List<MessageModel>? message;
  final String? token;
  final ModelUser? user;

  const SignUpResponse({this.message, this.token, this.user});

  factory SignUpResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpResponseToJson(this);

  @override
  List<Object?> get props => [message];
}
