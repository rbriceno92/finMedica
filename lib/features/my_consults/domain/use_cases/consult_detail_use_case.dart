import 'package:app/features/my_consults/data/models/consult_model.dart';
import 'package:app/features/my_consults/domain/repositories/consult_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

class ConsultDetailUseCase extends UseCase<ConsultModel, int> {
  final ConsultRepository repository;

  ConsultDetailUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, ConsultModel>> call(int param) async {
    return await repository.getConsultDetail(param);
  }
}
