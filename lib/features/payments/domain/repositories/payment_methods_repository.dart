import 'package:app/features/payments/data/models/create_payment_method_request.dart';
import 'package:app/features/payments/data/models/create_payment_method_response.dart';
import 'package:app/features/payments/data/models/delete_payment_method_request.dart';
import 'package:app/features/payments/data/models/delete_payment_method_response.dart';
import 'package:app/features/payments/data/models/payment_methods_response.dart';
import 'package:app/util/failure.dart';
import 'package:dartz/dartz.dart';

abstract class PaymentMethodsRepository {
  Future<Either<ErrorGeneral, PaymentMethodsResponse>> getPaymentMethods(
      String stripeCustomerId);

  Future<Either<ErrorGeneral, CreatePaymentMethodResponse>> createPaymentMethod(
      CreatePaymentMethodRequest request);

  Future<Either<ErrorGeneral, DeletePaymentMethodResponse>> deletePaymentMethod(
      DeletePaymentMethodRequest request);
}
