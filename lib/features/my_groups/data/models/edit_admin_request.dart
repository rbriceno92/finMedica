import 'package:json_annotation/json_annotation.dart';

part 'edit_admin_request.g.dart';

@JsonSerializable()
class EditAdminRequest {
  @JsonKey(name: 'id_admin')
  final String? adminId;
  @JsonKey(name: 'id_new_admin')
  final String? newAdminId;
  @JsonKey(name: 'group_id')
  final String? groupId;

  const EditAdminRequest({
    this.adminId,
    this.newAdminId,
    this.groupId,
  });

  factory EditAdminRequest.fromJson(Map<String, dynamic> json) =>
      _$EditAdminRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EditAdminRequestToJson(this);
}
