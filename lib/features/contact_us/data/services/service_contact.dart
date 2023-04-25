import 'package:chopper/chopper.dart';

import '../models/contact_us_data_request.dart';

part 'service_contact.chopper.dart';

@ChopperApi()
abstract class ServiceContact extends ChopperService {
  static ServiceContact create([ChopperClient? client]) =>
      _$ServiceContact(client);

  @Post(path: 'general/contact')
  Future<Response> postContact(@Body() ContactUsDataRequest nextConsultRequest,
      @Header('Authorization') String token);
}
