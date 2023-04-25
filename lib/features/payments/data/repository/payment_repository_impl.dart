import 'dart:io';

import 'package:app/core/di/modules.dart';
import 'package:app/features/payments/data/models/create_payment_request.dart';
import 'package:app/features/payments/data/models/create_payment_response.dart';
import 'package:app/features/payments/data/models/payment_config_request.dart';
import 'package:app/features/payments/data/models/payment_config_response.dart';
import 'package:app/features/payments/data/services/service_payments.dart';
import 'package:app/features/payments/domain/repositories/payment_repository.dart';
import 'package:app/util/constants/constants.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/models/error_model_server.dart';
import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentRepositoryImpl extends PaymentRepository {
  final ChopperClient chopperClient;

  PaymentRepositoryImpl({required this.chopperClient});

  @override
  Future<Either<ErrorGeneral, PaymentConfigResponse>> getPaymentConfig(
      String email) async {
    final service = chopperClient.getService<ServicePayments>();
    final prefs = getIt<SharedPreferences>();
    var token = prefs.getString('token');
    try {
      var paymentConfig = await service.getPaymentConfig(
          PaymentConfigRequest(email: email), token ?? '');

      if (paymentConfig.isSuccessful) {
        final result = getPaymentConfigResponse(paymentConfig.body);
        return Right(result);
      } else {
        return Left(ServerFailure(
            modelServer:
                getError(paymentConfig.error as Map<String, dynamic>)));
      }
    } on SocketException {
      return const Left(ErrorMessage(message: CONNECTION_ERROR));
    } catch (e) {
      return const Left(ErrorMessage(message: UNEXPECTED_ERROR));
    }
  }

  @override
  Future<Either<ErrorGeneral, CreatePaymentResponse>> createPaymentIntent(
      CreatePaymentRequest request) async {
    final service = chopperClient.getService<ServicePayments>();
    final prefs = getIt<SharedPreferences>();
    var token = prefs.getString('token');

    try {
      var response = await service.createPaymentIntent(request, token ?? '');

      if (response.isSuccessful) {
        final result = getCreatePaymentResponse(response.body);
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

  PaymentConfigResponse getPaymentConfigResponse(
          Map<String, dynamic> jsonBody) =>
      PaymentConfigResponse.fromJson(jsonBody);

  CreatePaymentResponse getCreatePaymentResponse(
          Map<String, dynamic> jsonBody) =>
      CreatePaymentResponse.fromJson(jsonBody);

  ErrorModelServer getError(Map<String, dynamic> jsonError) {
    return ErrorModelServer.fromJson(jsonError);
  }
}
