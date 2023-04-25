import 'package:app/features/signup/data/models/sign_up_model.dart';
import 'package:app/features/signup/data/models/sign_up_response.dart';
import 'package:app/util/failure.dart';
import 'package:dartz/dartz.dart';

abstract class SignUpRepository {
  Future<Either<ErrorGeneral, SignUpResponse>> signUp(ModelSignUp signUp);
}
