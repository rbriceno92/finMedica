import 'dart:io';

import 'package:app/features/profile/data/models/update_data_user_response.dart';
import 'package:app/features/profile/domain/repositories/update_data_user_repository.dart';
import 'package:app/util/constants/constants.dart';
import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';
import 'package:app/util/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/di/modules.dart';
import '../../../../util/models/error_model_server.dart';
import '../models/update_data_user_model.dart';
import '../services/service_update_data_user.dart';

class UpdateDataUserImpl implements UpdateDataUserRepository {
  final ChopperClient chopperClient;

  UpdateDataUserImpl({required this.chopperClient});

  @override
  Future<Either<ErrorGeneral, UpdateDataUserResponse>> upDateData(
      UpdateDataUserModel updateData) async {
    final prefs = getIt<SharedPreferences>();
    var token = prefs.getString('token');
    final service = chopperClient.getService<ServiceUpdateDataUser>();

    try {
      final response = await service.upDateData(updateData, token);
      if (response.isSuccessful) {
        final result = UpdateDataUserResponse(message: response.body);
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

  UpdateDataUserResponse getResult(Map<String, dynamic> json) {
    return UpdateDataUserResponse.fromJson(json);
  }

  getError(Map<String, dynamic> error) {
    return ErrorModelServer.fromJson(error);
  }
}
