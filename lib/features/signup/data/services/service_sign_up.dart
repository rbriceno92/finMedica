import 'package:app/features/signup/data/models/sign_up_model.dart';
import 'package:chopper/chopper.dart';

part 'service_sign_up.chopper.dart';

@ChopperApi()
abstract class ServiceSignUp extends ChopperService {
  static ServiceSignUp create([ChopperClient? client]) =>
      _$ServiceSignUp(client);

  @Post(path: 'auth/signup')
  Future<Response> signUp(@Body() ModelSignUp modelSignUp);
}
