import 'package:app/util/failure.dart';
import 'package:dartz/dartz.dart';

abstract class RefreshRepository {
  Future<Either<ErrorGeneral, String>> refreshToken(String email);
}
