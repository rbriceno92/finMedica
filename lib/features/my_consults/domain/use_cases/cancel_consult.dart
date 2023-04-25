import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/cancel_consult_response.dart';
import '../repositories/cancel_consult_repository.dart';

class CancelConsultUseCase extends UseCase<CancelConsultResponse, int> {
  final CancelConsultRepository repository;

  CancelConsultUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, CancelConsultResponse>> call(int param) async {
    return await repository.cancelConsult(param);
  }
}
