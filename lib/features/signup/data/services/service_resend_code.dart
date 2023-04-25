import 'package:chopper/chopper.dart';

import '../models/resend_code_model.dart';

part 'service_resend_code.chopper.dart';

@ChopperApi()
abstract class ServiceResendCode extends ChopperService {
  static ServiceResendCode create([ChopperClient? client]) =>
      _$ServiceResendCode(client);

  @Post(path: 'auth/resend-temporal-code')
  Future<Response> resendCode(@Body() ResendCodeModel userId);
}
