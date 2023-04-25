// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';

part 'sign_up_model.g.dart';

@JsonSerializable()
class ModelSignUp {
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'second_name')
  final String secondName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'second_last_name')
  final String mothersLastName;
  final String gender;
  final String email;
  @JsonKey(name: 'phone_number', includeIfNull: false)
  final String phone;
  final String birthday;
  @JsonKey(name: 'document_id')
  final String curp;
  final String password;
  final int age;

  const ModelSignUp({
    required this.firstName,
    required this.secondName,
    required this.lastName,
    required this.mothersLastName,
    required this.gender,
    required this.email,
    required this.phone,
    required this.birthday,
    required this.curp,
    required this.password,
    required this.age,
  });

  factory ModelSignUp.fromJson(Map<String, dynamic> json) =>
      _$ModelSignUpFromJson(json);

  Map<String, dynamic> toJson() => _$ModelSignUpToJson(this);
}
