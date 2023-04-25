import 'package:app/features/change_password/data/models/change_password_request.dart';
import 'package:chopper/chopper.dart';

part 'service_change_password.chopper.dart';

@ChopperApi()
abstract class ServiceChangePassword extends ChopperService {
  static ServiceChangePassword create([ChopperClient? client]) =>
      _$ServiceChangePassword(client);

  @Post(path: 'auth/update-password')
  Future<Response> updatePassword(
    @Body() ChangePasswordRequest body,
    @Header('Authorization') String token,
  );
}
