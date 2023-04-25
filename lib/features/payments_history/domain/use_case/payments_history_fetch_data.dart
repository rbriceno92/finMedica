import 'package:app/features/payments_history/data/models/payment_history_response.dart';
import 'package:app/features/payments_history/domain/repository/payment_history_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

class PaymentHistoryFetchDataUseCase
    extends UseCase<PaymentHistoryResponse, String> {
  final PaymentHistoryRepository repository;

  PaymentHistoryFetchDataUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, PaymentHistoryResponse>> call(
      String param) async {
    return await repository.fetchData(param);
  }
}
