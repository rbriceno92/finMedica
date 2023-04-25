import 'package:app/features/forgot_password/data/models/send_email_model.dart';
import 'package:app/features/forgot_password/data/models/send_email_response.dart';
import 'package:app/features/forgot_password/data/models/update_password_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../util/failure.dart';

abstract class ForgotPasswordRepository {
  Future<Either<ErrorGeneral, SendEmailResponse>> sendEmail(String email);

  Future<Either<ErrorGeneral, String>> validateCode(SendEmailModel model);

  Future<Either<ErrorGeneral, bool>> resetPassword(UpdatePasswordModel param);
}
