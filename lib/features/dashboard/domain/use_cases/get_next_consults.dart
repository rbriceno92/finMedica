import 'package:app/features/dashboard/domain/repositories/dashboard_repositories.dart';
import 'package:app/features/my_consults/data/models/consult_model.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

class GetNextConsults extends UseCase<List<ConsultModel>, Map> {
  final DashboardRepository repository;

  GetNextConsults({required this.repository});

  @override
  Future<Either<ErrorGeneral, List<ConsultModel>>> call(Map param) async {
    return await repository.getNextConsults(param);
  }
}
