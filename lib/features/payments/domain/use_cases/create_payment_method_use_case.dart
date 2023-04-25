import 'package:app/features/payments/data/models/create_payment_method_request.dart';
import 'package:app/features/payments/data/models/create_payment_method_response.dart';
import 'package:app/features/payments/domain/repositories/payment_methods_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

class CreatePaymentMethodUseCase
    extends UseCase<CreatePaymentMethodResponse, CreatePaymentMethodRequest> {
  final PaymentMethodsRepository repository;

  CreatePaymentMethodUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, CreatePaymentMethodResponse>> call(
      CreatePaymentMethodRequest param) {
    return repository.createPaymentMethod(param);
  }
}
