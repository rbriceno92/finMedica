import 'dart:io';

import 'package:app/features/signup/data/models/resend_code_response.dart';
import 'package:app/features/signup/data/models/resend_code_model.dart';
import 'package:app/features/signup/domain/repositories/resend_code.dart';
import 'package:app/util/constants/constants.dart';
import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';
import 'package:app/util/failure.dart';

import '../../../../util/models/error_model_server.dart';
import '../services/service_resend_code.dart';

class ResendCodeRepositoryImpl implements ResendCodeRepository {
  final ChopperClient chopperClient;
  ResendCodeRepositoryImpl({required this.chopperClient});

  @override
  Future<Either<ErrorGeneral, ResendCodeResponse>> resendCode(
      ResendCodeModel userId) async {
    final service = chopperClient.getService<ServiceResendCode>();
    try {
      final response = await service.resendCode(userId);
      if (response.isSuccessful) {
        final result = ResendCodeResponse(message: response.body);
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

  ErrorModelServer getError(Map<String, dynamic> jsonError) {
    return ErrorModelServer.fromJson(jsonError);
  }
}
