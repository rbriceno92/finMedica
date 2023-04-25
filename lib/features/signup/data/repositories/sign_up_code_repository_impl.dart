import 'dart:io';

import 'package:app/features/signup/data/models/sign_up_code_request.dart';
import 'package:app/features/signup/data/models/sign_up_code_response.dart';
import 'package:app/features/signup/data/services/service_sign_up_verify.dart';
import 'package:app/features/signup/domain/repositories/sign_up_code_repository.dart';
import 'package:app/util/constants/constants.dart';
import 'package:app/util/models/error_model_server.dart';
import 'package:app/util/failure.dart';
import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';

class SignUpCodeRepositoryImpl implements SignUpCodeRepository {
  final ChopperClient chopperClient;

  SignUpCodeRepositoryImpl({required this.chopperClient});

  @override
  Future<Either<ErrorGeneral, SignUpCodeResponse>> verify(
      SignUpCodeRequest request) async {
    final service = chopperClient.getService<ServiceSignUpVerify>();

    try {
      final response = await service.verify(request);

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

  SignUpCodeResponse getResult(Map<String, dynamic> json) {
    return SignUpCodeResponse.fromJson(json);
  }

  ErrorModelServer getError(Map<String, dynamic> jsonError) {
    return ErrorModelServer.fromJson(jsonError);
  }
}
