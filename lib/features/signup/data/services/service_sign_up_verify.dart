import 'package:app/features/signup/data/models/sign_up_code_request.dart';
import 'package:chopper/chopper.dart';

part 'service_sign_up_verify.chopper.dart';

@ChopperApi()
abstract class ServiceSignUpVerify extends ChopperService {
  static ServiceSignUpVerify create([ChopperClient? client]) =>
      _$ServiceSignUpVerify(client);

  @Post(path: 'auth/verify')
  Future<Response> verify(@Body() SignUpCodeRequest request);
}
