import 'package:json_annotation/json_annotation.dart';

part 'add_member_existent_request.g.dart';

@JsonSerializable()
class AddMemberExistentRequest {
  @JsonKey(name: 'id_admin')
  final String idAdmin;
  @JsonKey(name: 'member_id')
  final String userId;
  @JsonKey(name: 'group_id')
  final String groupId;

  const AddMemberExistentRequest({
    required this.idAdmin,
    required this.userId,
    required this.groupId,
  });

  factory AddMemberExistentRequest.fromJson(Map<String, dynamic> json) =>
      _$AddMemberExistentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddMemberExistentRequestToJson(this);
}
