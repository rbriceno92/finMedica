import 'package:app/features/forgot_password/data/models/password_model.dart';
import 'package:app/features/forgot_password/data/models/send_email_model.dart';
import 'package:chopper/chopper.dart';

part 'forgot_password_services.chopper.dart';

@ChopperApi()
abstract class ServiceForgotPassword extends ChopperService {
  static ServiceForgotPassword create([ChopperClient? client]) =>
      _$ServiceForgotPassword(client);

  @Post(path: 'auth/forgot-password')
  Future<Response> sendEmail(@Body() SendEmailModel model);

  @Post(path: 'auth/reset-password')
  Future<Response> updatePassword(
      @Body() PasswordModel password, @Header('Authorization') token);
}
