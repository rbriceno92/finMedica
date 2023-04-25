import 'package:app/features/signup/data/models/sign_up_code_request.dart';
import 'package:app/features/signup/data/models/sign_up_code_response.dart';
import 'package:app/util/failure.dart';
import 'package:dartz/dartz.dart';

abstract class SignUpCodeRepository {
  Future<Either<ErrorGeneral, SignUpCodeResponse>> verify(
      SignUpCodeRequest request);
}
