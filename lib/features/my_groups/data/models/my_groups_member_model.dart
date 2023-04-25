import 'package:app/features/my_groups/domain/entities/my_groups_member.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/general_fuctions.dart';
import 'package:app/util/models/model_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_groups_member_model.g.dart';

@JsonSerializable()
class MyGroupsMemberModel extends ModelUser {
  @JsonKey(name: 'group_id')
  final String? groupId;

  const MyGroupsMemberModel(
      {super.userId,
      super.firstName,
      super.isVerified,
      super.secondName,
      super.lastName,
      super.mothersLastName,
      super.phoneNumber,
      super.birthday,
      super.age,
      super.email,
      super.gender,
      super.documentId,
      super.idUserAlephoo,
      super.updatedAt,
      super.createdAt,
      super.idBoss,
      super.customId,
      this.groupId});

  factory MyGroupsMemberModel.fromJson(Map<String, dynamic> json) =>
      _$MyGroupsMemberModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MyGroupsMemberModelToJson(this);

  MyGroupsMember toEntity() => MyGroupsMember(
        userId: userId,
        firstName: firstName,
        secondName: secondName,
        lastName: lastName,
        mothersLastName: mothersLastName,
        phoneNumber: phoneNumber,
        birthday: birthday,
        age: age ?? howManyYears(birthday, format: 'yyyy-MM-dd'),
        email: email,
        gender: gender,
        documentId: documentId,
        idUserAlephoo: idUserAlephoo,
        updatedAt: updatedAt,
        createdAt: createdAt,
        customId: customId,
        isVerified: isVerified,
      );

  @override
  List<Object?> get props => [
        userId,
        firstName,
        secondName,
        lastName,
        mothersLastName,
        gender,
        email,
        birthday,
        age,
        documentId,
        phoneNumber,
        idUserAlephoo,
        updatedAt,
        createdAt,
        groupId,
        customId,
        isVerified
      ];
}
