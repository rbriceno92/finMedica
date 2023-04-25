import 'dart:io';

import 'package:app/features/login/data/models/credential_model.dart';
import 'package:app/features/login/data/models/login_response.dart';
import 'package:app/features/login/data/services/service_login.dart';
import 'package:app/features/login/domain/repositories/sign_in_repository.dart';
import 'package:app/util/constants/constants.dart';
import 'package:app/util/failure.dart';
import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';

import '../../../../util/models/error_model_server.dart';

class SignInRepositoryImpl implements SignInRepository {
  final ChopperClient chopperClient;

  SignInRepositoryImpl({required this.chopperClient});

  @override
  Future<Either<ErrorGeneral, LoginResponse>> signIn(
      ModelCredential credential) async {
    final service = chopperClient.getService<ServiceLogin>();

    try {
      final response = await service.login(credential);

      if (response.isSuccessful) {
        final result = getUser(response.body);
        return Right(result);
      } else {
        return Left(ServerFailure(
            modelServer: getError(response.error as Map<String, dynamic>)));
      }
    } on SocketException {
      return const Left(ErrorMessage(message: CONNECTION_ERROR));
    } catch (e) {
      return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
    }
  }

  LoginResponse getUser(Map<String, dynamic> json) {
    return LoginResponse.fromJson(json);
  }

  ErrorModelServer getError(Map<String, dynamic> jsonError) {
    return ErrorModelServer.fromJson(jsonError);
  }
}
