import 'package:app/features/my_groups/data/models/get_my_groups_data_response.dart';
import 'package:app/features/my_groups/domain/entities/my_groups_info.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_my_groups_response.g.dart';

@JsonSerializable()
class CreateMyGroupsResponse extends Equatable {
  final CreateGroupResponse group;
  final GetMyGroupsDataResponse groupMembers;
  final String message;

  factory CreateMyGroupsResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateMyGroupsResponseFromJson(json);

  const CreateMyGroupsResponse(
      {required this.group, required this.groupMembers, required this.message});

  Map<String, dynamic> toJson() => _$CreateMyGroupsResponseToJson(this);

  MyGroupsInfo toEntidad() => MyGroupsInfo(
        id: groupMembers.id,
        groupId: groupMembers.groupId,
        idAdmin: groupMembers.idAdmin,
        isAdmin: true,
      );

  @override
  List<Object?> get props => [group, groupMembers, message];
}

@JsonSerializable()
class CreateGroupResponse extends Equatable {
  @JsonKey(name: 'group_id')
  final String groupId;
  @JsonKey(name: 'id_admin')
  final String idAdmin;
  final String createdAt;
  final String updatedAt;

  factory CreateGroupResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateGroupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateGroupResponseToJson(this);

  const CreateGroupResponse(
      {required this.groupId,
      required this.idAdmin,
      required this.createdAt,
      required this.updatedAt});

  @override
  List<Object?> get props => [groupId, idAdmin, createdAt, updatedAt];
}
