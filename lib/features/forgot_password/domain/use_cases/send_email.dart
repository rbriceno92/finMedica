import 'package:app/features/forgot_password/data/models/send_email_response.dart';
import 'package:app/features/forgot_password/domain/repositories/forgot_password_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

class SendEmail extends UseCase<SendEmailResponse, String> {
  final ForgotPasswordRepository forgotPasswordRepository;

  SendEmail({required this.forgotPasswordRepository});

  @override
  Future<Either<ErrorGeneral, SendEmailResponse>> call(String param) async {
    return await forgotPasswordRepository.sendEmail(param.trim().toLowerCase());
  }
}
