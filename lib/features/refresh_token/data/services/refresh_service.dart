import 'package:app/features/refresh_token/data/models/request_refresh_token.dart';
import 'package:chopper/chopper.dart';

part 'refresh_service.chopper.dart';

@ChopperApi()
abstract class RefreshService extends ChopperService {
  static RefreshService create([ChopperClient? client]) =>
      _$RefreshService(client);

  @Post(path: 'auth/refresh-token')
  Future<Response> refreshToken(@Body() RefreshTokenRequest request,
      @Header('Authorization') String token);
}
