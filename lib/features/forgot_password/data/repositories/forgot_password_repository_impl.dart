import 'dart:io';

import 'package:app/features/forgot_password/data/models/password_model.dart';
import 'package:app/features/forgot_password/data/models/send_email_model.dart';
import 'package:app/features/forgot_password/data/models/send_email_response.dart';
import 'package:app/features/forgot_password/data/models/update_password_model.dart';
import 'package:app/features/forgot_password/data/services/forgot_password_services.dart';
import 'package:app/features/forgot_password/domain/repositories/forgot_password_repository.dart';
import 'package:app/util/constants/constants.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/models/error_model_server.dart';
import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';

class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  final ChopperClient chopperClient;

  ForgotPasswordRepositoryImpl({required this.chopperClient});

  @override
  Future<Either<ErrorGeneral, bool>> resetPassword(
      UpdatePasswordModel param) async {
    final service = chopperClient.getService<ServiceForgotPassword>();

    try {
      final response = await service.updatePassword(
          PasswordModel(password: param.password), 'Bearer ${param.token}');
      if (response.isSuccessful) {
        return const Right(true);
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

  @override
  Future<Either<ErrorGeneral, SendEmailResponse>> sendEmail(
      String email) async {
    final service = chopperClient.getService<ServiceForgotPassword>();
    var modelSendEmail = SendEmailModel(email: email, validateCode: false);
    try {
      final response = await service.sendEmail(modelSendEmail);
      if (response.isSuccessful) {
        return Right(getEmailResponse(response.body));
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

  @override
  Future<Either<ErrorGeneral, String>> validateCode(
      SendEmailModel param) async {
    final service = chopperClient.getService<ServiceForgotPassword>();
    try {
      final response = await service.sendEmail(param);
      if (response.isSuccessful) {
        var json = response.body as Map<String, dynamic>;
        return Right(json['token']);
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

  SendEmailResponse getEmailResponse(Map<String, dynamic> body) {
    return SendEmailResponse.fromJson(body);
  }
}
