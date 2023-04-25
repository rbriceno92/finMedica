import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/my_groups_info.dart';

part 'get_my_groups_data_response.g.dart';

@JsonSerializable()
class GetMyGroupsDataResponse extends Equatable {
  final String id;
  @JsonKey(name: 'group_id')
  final String groupId;
  @JsonKey(name: 'is_admin')
  final bool isAdmin;
  @JsonKey(name: 'id_admin')
  final String idAdmin;
  @JsonKey(name: 'members_id')
  final List<String> members;
  final String createdAt;
  final String updatedAt;

  factory GetMyGroupsDataResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMyGroupsDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetMyGroupsDataResponseToJson(this);

  const GetMyGroupsDataResponse(
      {required this.id,
      required this.groupId,
      this.isAdmin = true,
      required this.idAdmin,
      required this.members,
      required this.createdAt,
      required this.updatedAt});

  MyGroupsInfo toEntity() => MyGroupsInfo(
        id: id,
        groupId: groupId,
        isAdmin: isAdmin,
        idAdmin: idAdmin,
      );

  @override
  List<Object?> get props =>
      [id, groupId, isAdmin, idAdmin, members, createdAt, updatedAt];
}
