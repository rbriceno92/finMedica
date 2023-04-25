import 'package:app/features/payments/data/models/payment_methods_response.dart';
import 'package:app/features/payments/domain/repositories/payment_methods_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

class GetPaymentMethodsUseCase extends UseCase<PaymentMethodsResponse, String> {
  final PaymentMethodsRepository repository;

  GetPaymentMethodsUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, PaymentMethodsResponse>> call(String param) {
    return repository.getPaymentMethods(param);
  }
}
