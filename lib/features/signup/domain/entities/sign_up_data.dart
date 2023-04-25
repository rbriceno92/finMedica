import 'package:app/util/enums.dart';
import 'package:equatable/equatable.dart';

class SignUpData extends Equatable {
  final String firstName;
  final String secondName;
  final String lastName;
  final String mothersLastName;
  final Genders gender;
  final String phone;
  final String email;
  final String birthday;
  final String curp;
  final String password;

  const SignUpData({
    required this.firstName,
    required this.secondName,
    required this.lastName,
    required this.mothersLastName,
    required this.gender,
    required this.phone,
    required this.email,
    required this.birthday,
    required this.curp,
    required this.password,
  });

  SignUpData copyWith({
    String? firstName,
    String? secondName,
    String? lastName,
    String? mothersLastName,
    Genders? gender,
    String? phone,
    String? email,
    String? birthday,
    String? curp,
    String? password,
  }) {
    return SignUpData(
      firstName: firstName ?? this.firstName,
      secondName: secondName ?? this.secondName,
      lastName: lastName ?? this.lastName,
      mothersLastName: mothersLastName ?? this.mothersLastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      curp: curp ?? this.curp,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [
        firstName,
        secondName,
        lastName,
        mothersLastName,
        gender,
        phone,
        email,
        birthday,
        curp,
        password,
      ];
}
