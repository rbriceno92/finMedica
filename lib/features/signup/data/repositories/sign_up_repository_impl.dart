import 'dart:io';

import 'package:app/features/signup/data/models/sign_up_model.dart';
import 'package:app/features/signup/data/models/sign_up_response.dart';
import 'package:app/features/signup/data/services/service_sign_up.dart';
import 'package:app/features/signup/domain/repositories/sign_up_repository.dart';
import 'package:app/util/constants/constants.dart';
import 'package:app/util/models/error_model_server.dart';
import 'package:app/util/failure.dart';
import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final ChopperClient chopperClient;

  SignUpRepositoryImpl({required this.chopperClient});

  @override
  Future<Either<ErrorGeneral, SignUpResponse>> signUp(
      ModelSignUp signUp) async {
    final service = chopperClient.getService<ServiceSignUp>();

    try {
      final response = await service.signUp(signUp);

      if (response.isSuccessful) {
        final result = getResult(response.body);
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

  SignUpResponse getResult(Map<String, dynamic> json) {
    return SignUpResponse.fromJson(json);
  }

  ErrorModelServer getError(Map<String, dynamic> jsonError) {
    return ErrorModelServer.fromJson(jsonError);
  }
}
