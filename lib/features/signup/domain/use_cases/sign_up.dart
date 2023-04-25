import 'dart:convert';

import 'package:app/features/signup/data/models/sign_up_model.dart';
import 'package:app/features/signup/data/models/sign_up_response.dart';
import 'package:app/features/signup/domain/entities/sign_up_data.dart';
import 'package:app/features/signup/domain/repositories/sign_up_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/general_fuctions.dart';
import 'package:app/util/use_case.dart';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';

class SignUp extends UseCase<SignUpResponse, SignUpData> {
  final SignUpRepository signUpRepository;

  SignUp({required this.signUpRepository});

  @override
  Future<Either<ErrorGeneral, SignUpResponse>> call(SignUpData param) async {
    return await signUpRepository.signUp(ModelSignUp(
      age: howManyYears(param.birthday),
      birthday: param.birthday,
      curp: param.curp,
      email: param.email.trim().toLowerCase(),
      firstName: param.firstName,
      secondName: param.secondName,
      gender: param.gender.name,
      lastName: param.lastName,
      password: param.password.isEmpty
          ? ''
          : md5.convert(utf8.encode(param.password)).toString(),
      phone: param.phone,
      mothersLastName: param.mothersLastName,
    ));
  }
}
