import 'package:app/features/directory/data/models/speciality_model.dart';
import 'package:app/features/directory/domain/repositories/directory_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

class GetSpecialities extends UseCase<List<Speciality>, void> {
  final DirectoryRepository repository;

  GetSpecialities({required this.repository});

  @override
  Future<Either<ErrorGeneral, List<Speciality>>> call(void param) async {
    return await repository.getSpecialities();
  }
}
