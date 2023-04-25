import 'dart:io';

import 'package:app/features/refresh_token/data/models/request_refresh_token.dart';
import 'package:app/features/refresh_token/data/services/refresh_service.dart';
import 'package:app/features/refresh_token/domain/repository/refresh_repository.dart';
import 'package:app/util/constants/constants.dart';
import 'package:app/util/failure.dart';
import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../util/models/error_model_server.dart';

class RefreshTokenRepositoryImpl extends RefreshRepository {
  final ChopperClient chopperClient;

  RefreshTokenRepositoryImpl({required this.chopperClient});

  @override
  Future<Either<ErrorGeneral, String>> refreshToken(String email) async {
    final service = chopperClient.getService<RefreshService>();
    var sp = await SharedPreferences.getInstance();
    var token = sp.getString('token');
    try {
      final response = await service.refreshToken(
          RefreshTokenRequest(email: email), token ?? '');

      if (response.isSuccessful) {
        final result = getToken(response.body);
        return Right(result);
      } else {
        return Left(ErrorMessage(message: response.error.toString()));
      }
    } on SocketException {
      return const Left(ErrorMessage(message: CONNECTION_ERROR));
    } catch (e) {
      return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
    }
  }

  String getToken(Map<String, dynamic> json) {
    return json['newToken'] as String;
  }

  ErrorModelServer getError(Map<String, dynamic> jsonError) {
    return ErrorModelServer.fromJson(jsonError);
  }
}
