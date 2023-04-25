import 'package:json_annotation/json_annotation.dart';

part 'create_new_member_request.g.dart';

@JsonSerializable()
class CreateMyNewMemberRequest {
  @JsonKey(name: 'id_boss')
  final String? idBoss;
  @JsonKey(name: 'group_id')
  final String? groupId;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'second_name')
  final String? secondName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'second_last_name')
  final String? mothersLastName;
  final String? birthday;
  final String? email;
  @JsonKey(name: 'document_id')
  final String? documentId;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final String? gender;
  final int? age;
  const CreateMyNewMemberRequest({
    this.groupId,
    this.firstName,
    this.secondName,
    this.lastName,
    this.mothersLastName,
    this.birthday,
    this.email,
    this.documentId,
    this.phoneNumber,
    this.gender,
    this.age,
    required this.idBoss,
  });

  factory CreateMyNewMemberRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateMyNewMemberRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateMyNewMemberRequestToJson(this);
}
