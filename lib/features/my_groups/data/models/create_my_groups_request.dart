import 'package:json_annotation/json_annotation.dart';

part 'create_my_groups_request.g.dart';

@JsonSerializable()
class CreateMyGroupsRequest {
  @JsonKey(name: 'id_admin')
  final String idAdmin;

  const CreateMyGroupsRequest({
    required this.idAdmin,
  });

  factory CreateMyGroupsRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateMyGroupsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateMyGroupsRequestToJson(this);
}
