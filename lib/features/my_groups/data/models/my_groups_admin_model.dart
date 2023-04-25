import 'package:app/features/my_groups/domain/entities/my_groups_admin.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/general_fuctions.dart';
import 'package:app/util/models/model_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_groups_admin_model.g.dart';

@JsonSerializable()
class MyGroupsAdminModel extends ModelUser {
  const MyGroupsAdminModel({
    super.userId,
    super.firstName,
    super.secondName,
    super.lastName,
    super.mothersLastName,
    super.phoneNumber,
    super.birthday,
    super.age,
    super.isVerified,
    super.email,
    super.gender,
    super.documentId,
    super.idUserAlephoo,
    super.termsConditions,
    super.updatedAt,
    super.createdAt,
    super.stripeCustomerId,
  });

  factory MyGroupsAdminModel.fromJson(Map<String, dynamic> json) =>
      _$MyGroupsAdminModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MyGroupsAdminModelToJson(this);

  MyGroupsAdmin toEntity() => MyGroupsAdmin(
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
      );

  @override
  List<Object?> get props => [firstName, lastName, gender, age];
}
