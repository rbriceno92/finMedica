import 'dart:io';

import 'package:app/features/payments_history/data/models/payment_history_response.dart';
import 'package:app/features/payments_history/domain/repository/payment_history_repository.dart';
import 'package:app/util/constants/constants.dart';
import 'package:app/util/models/error_model_server.dart';
import 'package:app/util/failure.dart';
import 'package:chopper/chopper.dart';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/di/modules.dart';
import '../../../../util/user_preferences_save.dart';
import '../services/service_history.dart';

class PaymentHistoryRepositoryImpl implements PaymentHistoryRepository {
  final ChopperClient chopperClient;
  final UserPreferenceDao dao;
  PaymentHistoryRepositoryImpl(
      {required this.chopperClient, required this.dao});

  @override
  Future<Either<ErrorGeneral, PaymentHistoryResponse>> fetchData(
      String filter) async {
    final userResponse = await dao.getUser();

    return userResponse.fold((error) {
      return const Left(ErrorMessage(message: USER_NOT_FOUND));
    }, (modelUser) async {
      final service = chopperClient.getService<ServiceHistory>();
      final prefs = getIt<SharedPreferences>();
      var token = prefs.getString('token');
      var stripeCustomerId = modelUser.stripeCustomerId;

      try {
        var historyPayments = await service.fetchData(
            '${filter != '' ? '$stripeCustomerId$filter' : stripeCustomerId}',
            token ?? '');
        if (historyPayments.isSuccessful) {
          final result = getResult(historyPayments.body);
          return Right(result);
        } else {
          return Left(ServerFailure(
              modelServer:
                  getError(historyPayments.error as Map<String, dynamic>)));
        }
      } on SocketException {
        return const Left(ErrorMessage(message: CONNECTION_ERROR));
      } catch (e) {
        return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
      }
    });
  }

  PaymentHistoryResponse getResult(Map<String, dynamic> body) {
    return PaymentHistoryResponse.fromJson(body);
  }

  ErrorModelServer getError(Map<String, dynamic> jsonError) {
    return ErrorModelServer.fromJson(jsonError);
  }
}
