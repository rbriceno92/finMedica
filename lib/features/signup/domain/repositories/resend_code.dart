import 'package:dartz/dartz.dart';

import '../../../../util/failure.dart';
import '../../data/models/resend_code_model.dart';
import '../../data/models/resend_code_response.dart';

abstract class ResendCodeRepository {
  Future<Either<ErrorGeneral, ResendCodeResponse>> resendCode(
      ResendCodeModel userId);
}
