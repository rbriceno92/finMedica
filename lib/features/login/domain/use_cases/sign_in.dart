import 'dart:convert';

import 'package:app/features/login/data/models/credential_model.dart';
import 'package:app/features/login/data/models/login_response.dart';
import 'package:app/features/login/domain/entities/credentials.dart';
import 'package:app/features/login/domain/repositories/sign_in_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';

class SignIn extends UseCase<LoginResponse, Credentials> {
  final SignInRepository signInRepository;

  SignIn({required this.signInRepository});

  @override
  Future<Either<ErrorGeneral, LoginResponse>> call(Credentials param) async {
    return await signInRepository.signIn(ModelCredential(
        email: param.email.toLowerCase(),
        password: md5.convert(utf8.encode(param.password)).toString()));
  }
}
