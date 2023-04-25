import 'package:app/features/payments/data/models/payment_config_response.dart';
import 'package:app/features/payments/domain/repositories/payment_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

class GetPaymentConfigUseCase extends UseCase<PaymentConfigResponse, String> {
  final PaymentRepository repository;

  GetPaymentConfigUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, PaymentConfigResponse>> call(String param) async {
    return await repository.getPaymentConfig(param);
  }
}
