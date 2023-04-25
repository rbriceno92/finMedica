import 'package:app/features/payments/data/models/create_payment_request.dart';
import 'package:app/features/payments/data/models/create_payment_response.dart';
import 'package:app/features/payments/data/models/payment_config_response.dart';
import 'package:app/util/failure.dart';
import 'package:dartz/dartz.dart';

abstract class PaymentRepository {
  Future<Either<ErrorGeneral, PaymentConfigResponse>> getPaymentConfig(
      String email);

  Future<Either<ErrorGeneral, CreatePaymentResponse>> createPaymentIntent(
      CreatePaymentRequest request);
}
