import 'package:app/features/my_consults/data/models/consult_private_params.dart';
import 'package:dartz/dartz.dart';

import '../../../../util/failure.dart';
import '../../../../util/use_case.dart';
import '../repositories/consult_repository.dart';

class MakeConsultPrivateUseCase extends UseCase<bool, ConsultPrivateParams> {
  final ConsultRepository repository;

  MakeConsultPrivateUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, bool>> call(ConsultPrivateParams param) async {
    return await repository.makeConsultPrivate(param);
  }
}
