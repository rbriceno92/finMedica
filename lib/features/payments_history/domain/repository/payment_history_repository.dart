import 'package:app/features/payments_history/data/models/payment_history_response.dart';
import 'package:app/util/failure.dart';
import 'package:dartz/dartz.dart';

abstract class PaymentHistoryRepository {
  Future<Either<ErrorGeneral, PaymentHistoryResponse>> fetchData(String filter);
}
