import 'package:json_annotation/json_annotation.dart';

part 'remove_member_request.g.dart';

@JsonSerializable()
class RemoveMemberRequest {
  @JsonKey(name: 'member_id')
  final String userId;
  @JsonKey(name: 'group_id')
  final String groupId;

  const RemoveMemberRequest({
    required this.userId,
    required this.groupId,
  });

  factory RemoveMemberRequest.fromJson(Map<String, dynamic> json) =>
      _$RemoveMemberRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RemoveMemberRequestToJson(this);
}
