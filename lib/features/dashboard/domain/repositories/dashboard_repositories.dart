import 'package:app/features/my_consults/data/models/consult_model.dart';
import 'package:app/util/failure.dart';
import 'package:dartz/dartz.dart';

abstract class DashboardRepository {
  Future<Either<ErrorGeneral, List<ConsultModel>>> getNextConsults(Map states);
}
