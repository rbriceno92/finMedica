import 'package:app/util/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:app/util/string_extensions.dart';

import '../../features/my_groups/domain/entities/my_groups_member.dart';
import '../../generated/l10n.dart';

part 'model_user.g.dart';

@JsonSerializable()
class ModelUser extends Equatable {
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'second_name')
  final String? secondName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'second_last_name')
  final String? mothersLastName;
  final Genders? gender;
  final String? email;
  final String? birthday;
  final int? age;
  @JsonKey(name: 'document_id')
  final String? documentId;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'id_user_alephoo')
  final int? idUserAlephoo;
  @JsonKey(name: 'is_verified')
  final bool? isVerified;
  @JsonKey(name: 'terms_conditions')
  final bool? termsConditions;
  final String? updatedAt;
  final String? createdAt;
  @JsonKey(name: 'is_dependent')
  final bool? isDependent;
  @JsonKey(name: 'id_boss')
  final String? idBoss;
  @JsonKey(name: 'stripe_customer_id')
  final String? stripeCustomerId;
  @JsonKey(name: 'custom_id')
  final String? customId;

  const ModelUser({
    this.userId,
    this.firstName,
    this.secondName,
    this.lastName,
    this.mothersLastName,
    this.phoneNumber,
    this.birthday,
    this.age,
    this.isVerified,
    this.email,
    this.gender,
    this.documentId,
    this.idUserAlephoo,
    this.termsConditions,
    this.updatedAt,
    this.createdAt,
    this.isDependent,
    this.idBoss,
    this.stripeCustomerId,
    this.customId,
  });

  ModelUser copyWith({
    String? stripeCustomerId,
    String? userId,
    String? firstName,
    String? secondName,
    String? lastName,
    String? mothersLastName,
    Genders? gender,
    String? email,
    String? birthday,
    int? age,
    String? documentId,
    String? phoneNumber,
    int? idUserAlephoo,
    bool? isVerified,
    bool? termsConditions,
    String? updatedAt,
    String? createdAt,
    bool? isDependent,
    String? idBoss,
    String? customId,
  }) {
    return ModelUser(
        stripeCustomerId: stripeCustomerId ?? this.stripeCustomerId,
        userId: userId ?? this.userId,
        firstName: firstName ?? this.firstName,
        secondName: secondName ?? this.secondName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        lastName: lastName ?? this.lastName,
        mothersLastName: mothersLastName ?? this.mothersLastName,
        birthday: birthday ?? this.birthday,
        isVerified: isVerified ?? this.isVerified,
        email: email ?? this.email,
        age: age ?? this.age,
        documentId: documentId ?? this.documentId,
        idUserAlephoo: idUserAlephoo ?? this.idUserAlephoo,
        gender: gender ?? this.gender,
        termsConditions: termsConditions ?? this.termsConditions,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isDependent: isDependent ?? this.isDependent,
        customId: customId ?? this.customId,
        idBoss: idBoss ?? this.idBoss);
  }

  factory ModelUser.fromJson(Map<String, dynamic> json) =>
      _$ModelUserFromJson(json);

  Map<String, dynamic> toJson() => _$ModelUserToJson(this);

  String fullName() {
    String firstName = this.firstName?.capitalizeOnlyFirstWord() ?? '';
    String secondName = this.secondName?.capitalizeOnlyFirstWord() ?? '';
    String lastName = this.lastName?.capitalizeOnlyFirstWord() ?? '';
    String mothersLastName =
        this.mothersLastName?.capitalizeOnlyFirstWord() ?? '';
    String full =
        '${firstName.isNotEmpty ? firstName : ''}${secondName.isNotEmpty ? ' $secondName' : ''}${lastName.isNotEmpty ? ' $lastName' : ''}${mothersLastName.isNotEmpty ? ' $mothersLastName' : ''}';
    return full.isEmpty ? '--' : full;
  }

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
        isDependent,
        idBoss,
        stripeCustomerId,
        customId,
      ];

  bool isGroup() => this is MyGroupsMember;

  String getGender(BuildContext context) {
    if (gender == Genders.m) {
      return Languages.of(context).male;
    } else {
      return Languages.of(context).female;
    }
  }
}
