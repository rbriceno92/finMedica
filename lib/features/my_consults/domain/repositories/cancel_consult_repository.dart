import 'package:app/util/failure.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/cancel_consult_response.dart';

abstract class CancelConsultRepository {
  Future<Either<ErrorGeneral, CancelConsultResponse>> cancelConsult(
      int consultId);
}
