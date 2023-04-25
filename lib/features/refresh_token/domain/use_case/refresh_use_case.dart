import 'package:app/features/refresh_token/domain/repository/refresh_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

class RefreshUseCase extends UseCase<String, String> {
  final RefreshRepository repository;

  RefreshUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, String>> call(String param) async {
    return await repository.refreshToken(param.toLowerCase());
  }
}
