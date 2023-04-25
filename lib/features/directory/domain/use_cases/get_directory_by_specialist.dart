import 'package:app/features/directory/domain/entities/directory.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

import '../repositories/directory_repository.dart';

class GetDirectory extends UseCase<Directory, int> {
  final DirectoryRepository repository;

  GetDirectory({required this.repository});

  @override
  Future<Either<ErrorGeneral, Directory>> call(int param) async {
    return await repository.getDirectory(param);
  }
}
