import 'package:chopper/chopper.dart';

part 'service_history.chopper.dart';

@ChopperApi()
abstract class ServiceHistory extends ChopperService {
  static ServiceHistory create([ChopperClient? client]) =>
      _$ServiceHistory(client);

  @Get(path: 'user-payment-history/{filter}')
  Future<Response> fetchData(
      @Path() String filter, @Header('Authorization') String token);
}
