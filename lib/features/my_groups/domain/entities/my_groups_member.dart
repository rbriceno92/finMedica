import 'package:app/util/models/model_user.dart';

class MyGroupsMember extends ModelUser {
  const MyGroupsMember({
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
    super.customId,
  });

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
        isVerified,
        termsConditions,
        updatedAt,
        createdAt,
        stripeCustomerId,
        customId
      ];
}
