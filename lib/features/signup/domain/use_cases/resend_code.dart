import 'package:dartz/dartz.dart';

import 'package:app/util/failure.dart';

import '../../../../util/use_case.dart';
import '../../data/models/resend_code_model.dart';
import '../../data/models/resend_code_response.dart';
import '../repositories/resend_code.dart';

class ResendCode extends UseCase<ResendCodeResponse, ResendCodeModel> {
  final ResendCodeRepository repository;

  ResendCode({required this.repository});
  @override
  Future<Either<ErrorGeneral, ResendCodeResponse>> call(
      ResendCodeModel param) async {
    return await repository.resendCode(param);
  }
}
