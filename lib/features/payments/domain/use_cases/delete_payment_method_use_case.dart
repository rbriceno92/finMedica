import 'package:app/features/payments/data/models/delete_payment_method_request.dart';
import 'package:app/features/payments/data/models/delete_payment_method_response.dart';
import 'package:app/features/payments/domain/repositories/payment_methods_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

class DeletePaymentMethodUseCase
    extends UseCase<DeletePaymentMethodResponse, DeletePaymentMethodRequest> {
  final PaymentMethodsRepository repository;

  DeletePaymentMethodUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, DeletePaymentMethodResponse>> call(
      DeletePaymentMethodRequest param) {
    return repository.deletePaymentMethod(param);
  }
}
