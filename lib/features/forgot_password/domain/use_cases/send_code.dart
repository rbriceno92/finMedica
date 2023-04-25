import 'package:app/features/forgot_password/data/models/send_email_model.dart';
import 'package:app/features/forgot_password/domain/repositories/forgot_password_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

class SendCode extends UseCase<String, SendEmailModel> {
  final ForgotPasswordRepository forgotPasswordRepository;

  SendCode({required this.forgotPasswordRepository});

  @override
  Future<Either<ErrorGeneral, String>> call(SendEmailModel param) async {
    return await forgotPasswordRepository.validateCode(SendEmailModel(
        email: param.email.toLowerCase(),
        validateCode: param.validateCode,
        code: param.code));
  }
}
