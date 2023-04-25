import 'package:app/features/signup/data/models/sign_up_code_request.dart';
import 'package:app/features/signup/data/models/sign_up_code_response.dart';
import 'package:app/features/signup/domain/repositories/sign_up_code_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

class SignUpCode extends UseCase<SignUpCodeResponse, SignUpCodeRequest> {
  final SignUpCodeRepository repository;

  SignUpCode({required this.repository});

  @override
  Future<Either<ErrorGeneral, SignUpCodeResponse>> call(
      SignUpCodeRequest param) async {
    return await repository.verify(param);
  }
}
