import 'dart:io';

import 'package:app/core/di/modules.dart';
import 'package:app/features/payments/data/models/create_payment_method_request.dart';
import 'package:app/features/payments/data/models/create_payment_method_response.dart';
import 'package:app/features/payments/data/models/delete_payment_method_request.dart';
import 'package:app/features/payments/data/models/delete_payment_method_response.dart';
import 'package:app/features/payments/data/models/payment_methods_response.dart';
import 'package:app/features/payments/data/services/service_user_payment_methods.dart';
import 'package:app/features/payments/domain/repositories/payment_methods_repository.dart';
import 'package:app/util/constants/constants.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/models/error_model_server.dart';
import 'package:chopper/chopper.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentMethodsRepositoryImpl extends PaymentMethodsRepository {
  final ChopperClient chopperClient;

  PaymentMethodsRepositoryImpl({required this.chopperClient});

  @override
  Future<Either<ErrorGeneral, PaymentMethodsResponse>> getPaymentMethods(
      String stripeCustomerId) async {
    final service = chopperClient.getService<ServiceUserPaymentMethods>();
    final prefs = getIt<SharedPreferences>();
    var token = prefs.getString('token');
    try {
      var response = await service.getPaymentMethods(
        token ?? '',
        stripeCustomerId,
      );

      if (response.isSuccessful) {
        final result = getPaymentMethodsResponse(response.body);
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

  @override
  Future<Either<ErrorGeneral, CreatePaymentMethodResponse>> createPaymentMethod(
      CreatePaymentMethodRequest request) async {
    final service = chopperClient.getService<ServiceUserPaymentMethods>();
    final prefs = getIt<SharedPreferences>();
    var token = prefs.getString('token');

    try {
      var response = await service.createPaymentMethod(token ?? '', request);

      if (response.isSuccessful) {
        final result = getCreatePaymentMethodResponse(response.body);
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

  @override
  Future<Either<ErrorGeneral, DeletePaymentMethodResponse>> deletePaymentMethod(
      DeletePaymentMethodRequest request) async {
    final service = chopperClient.getService<ServiceUserPaymentMethods>();
    final prefs = getIt<SharedPreferences>();
    var token = prefs.getString('token');

    try {
      var response = await service.deletePaymentMethod(
          token ?? '', request.stripeCustomerId, request.paymentMethodId);

      if (response.isSuccessful) {
        final result = getDeletePaymentMethodResponse(response.body);
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

  PaymentMethodsResponse getPaymentMethodsResponse(
          Map<String, dynamic> jsonBody) =>
      PaymentMethodsResponse.fromJson(jsonBody);

  CreatePaymentMethodResponse getCreatePaymentMethodResponse(
          Map<String, dynamic> jsonBody) =>
      CreatePaymentMethodResponse.fromJson(jsonBody);

  DeletePaymentMethodResponse getDeletePaymentMethodResponse(
          Map<String, dynamic> jsonBody) =>
      DeletePaymentMethodResponse.fromJson(jsonBody);

  ErrorModelServer getError(Map<String, dynamic> jsonError) {
    return ErrorModelServer.fromJson(jsonError);
  }
}
