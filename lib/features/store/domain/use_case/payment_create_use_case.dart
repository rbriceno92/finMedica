import 'package:app/features/payments/data/models/create_payment_request.dart';
import 'package:app/features/payments/data/models/create_payment_response.dart';
import 'package:app/features/payments/domain/repositories/payment_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

class CreatePaymentIntentUseCase
    extends UseCase<CreatePaymentResponse, CreatePaymentRequest> {
  final PaymentRepository repository;

  CreatePaymentIntentUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, CreatePaymentResponse>> call(
      CreatePaymentRequest param) async {
    return await repository.createPaymentIntent(param);
  }
}
