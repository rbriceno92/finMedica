import 'package:app/util/models/message_model.dart';
import 'package:app/util/models/model_user.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_new_member_response.g.dart';

@JsonSerializable()
class CreateNewMemberResponse extends Equatable {
  final List<MessageModel>? message;
  final String? token;
  final ModelUser? user;
  final bool? update;

  const CreateNewMemberResponse(
      {this.message, this.token, this.user, this.update});

  factory CreateNewMemberResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateNewMemberResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateNewMemberResponseToJson(this);

  @override
  List<Object?> get props => [message];
}
