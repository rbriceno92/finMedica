import 'package:chopper/chopper.dart';
import '../models/cancel_consult_request.dart';
part 'services_cancel_consult.chopper.dart';

@ChopperApi()
abstract class ServiceCancelConsults extends ChopperService {
  static ServiceCancelConsults create([ChopperClient? client]) =>
      _$ServiceCancelConsults(client);

  @Post(path: 'appointment/cancel')
  Future<Response> cancelConsult(@Body() CancelConsultRequest consultId,
      @Header('Authorization') String token);
}
