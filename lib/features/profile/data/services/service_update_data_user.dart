import 'package:chopper/chopper.dart';

import '../models/update_data_user_model.dart';

part 'service_update_data_user.chopper.dart';

@ChopperApi()
abstract class ServiceUpdateDataUser extends ChopperService {
  static ServiceUpdateDataUser create([ChopperClient? client]) =>
      _$ServiceUpdateDataUser(client);

  @Put(path: 'auth/update-phonenumber')
  Future<Response> upDateData(
      @Body() UpdateDataUserModel updateData, @Header('Authorization') token);
}
