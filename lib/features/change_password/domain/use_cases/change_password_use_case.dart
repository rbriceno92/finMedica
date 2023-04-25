import 'dart:convert';

import 'package:app/features/change_password/data/models/change_password_request.dart';
import 'package:app/features/change_password/data/models/change_password_response.dart';
import 'package:app/features/change_password/domain/repositories/change_password_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:crypto/crypto.dart';

import 'package:dartz/dartz.dart';

class ChangePasswordUseCase
    extends UseCase<ChangePasswordResponse, ChangePasswordRequest> {
  final ChangePasswordRepository repository;

  ChangePasswordUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, ChangePasswordResponse>> call(
      ChangePasswordRequest param) async {
    return await repository.updatePassword(ChangePasswordRequest(
        password: md5.convert(utf8.encode(param.password)).toString(),
        currentPassword:
            md5.convert(utf8.encode(param.currentPassword)).toString()));
  }
}
