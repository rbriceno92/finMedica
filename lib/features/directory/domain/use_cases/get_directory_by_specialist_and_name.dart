import 'package:app/features/directory/domain/entities/directory.dart';
import 'package:app/features/directory/domain/entities/directory_by_specialist_and_name_param.dart';
import 'package:app/features/directory/domain/repositories/directory_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

class GetDirectoryBySpecialistAndName
    extends UseCase<Directory, DirectoryBySpecialistAndNameParam> {
  final DirectoryRepository repository;

  GetDirectoryBySpecialistAndName({required this.repository});

  @override
  Future<Either<ErrorGeneral, Directory>> call(
      DirectoryBySpecialistAndNameParam param) async {
    return await repository.getDirectoryBySpecialistAndName(
        param.specialist, param.name, param.hospital);
  }
}
