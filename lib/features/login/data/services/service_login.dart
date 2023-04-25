import 'package:app/features/login/data/models/credential_model.dart';
import 'package:chopper/chopper.dart';

part 'service_login.chopper.dart';

@ChopperApi()
abstract class ServiceLogin extends ChopperService {
  static ServiceLogin create([ChopperClient? client]) => _$ServiceLogin(client);

  @Post(path: 'auth/login')
  Future<Response> login(@Body() ModelCredential credential);
}
