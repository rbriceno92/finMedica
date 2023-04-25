import 'package:app/features/directory/data/models/clinic_model.dart';
import 'package:app/features/directory/domain/repositories/directory_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

class GetClinicUseCase extends UseCase<ClinicModel, void> {
  final DirectoryRepository repository;

  GetClinicUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, ClinicModel>> call(void param) async {
    return await repository.getClinicDefault();
  }
}
