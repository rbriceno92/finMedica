import 'dart:io';

import 'package:app/core/di/modules.dart';
import 'package:app/features/change_password/data/models/change_password_request.dart';
import 'package:app/features/change_password/data/models/change_password_response.dart';
import 'package:app/features/change_password/data/services/service_change_password.dart';
import 'package:app/features/change_password/domain/repositories/change_password_repository.dart';
import 'package:app/util/constants/constants.dart';
import 'package:app/util/models/error_model_server.dart';
import 'package:app/util/failure.dart';
import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordRepositoryImpl implements ChangePasswordRepository {
  final ChopperClient chopperClient;

  ChangePasswordRepositoryImpl({required this.chopperClient});

  @override
  Future<Either<ErrorGeneral, ChangePasswordResponse>> updatePassword(
      ChangePasswordRequest request) async {
    final service = chopperClient.getService<ServiceChangePassword>();
    final prefs = getIt<SharedPreferences>();

    var token = prefs.getString('token');

    try {
      final response = await service.updatePassword(request, token ?? '');

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

  ChangePasswordResponse getUser(Map<String, dynamic> json) {
    return ChangePasswordResponse.fromJson(json);
  }

  ErrorModelServer getError(Map<String, dynamic> jsonError) {
    return ErrorModelServer.fromJson(jsonError);
  }
}
