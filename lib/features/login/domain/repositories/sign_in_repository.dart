import 'package:app/features/login/data/models/credential_model.dart';
import 'package:app/features/login/data/models/login_response.dart';
import 'package:app/util/failure.dart';
import 'package:dartz/dartz.dart';

abstract class SignInRepository {
  Future<Either<ErrorGeneral, LoginResponse>> signIn(
      ModelCredential credential);
}
