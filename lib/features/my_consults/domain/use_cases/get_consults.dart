import 'package:app/features/my_consults/data/models/consult_model.dart';
import 'package:app/features/my_consults/domain/repositories/consult_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

class GetConsults extends UseCase<List<ConsultModel>, Map> {
  final ConsultRepository repository;

  GetConsults({required this.repository});

  @override
  Future<Either<ErrorGeneral, List<ConsultModel>>> call(Map param) async {
    return await repository.getListMyConsults(param);
  }
}
