import 'package:chopper/chopper.dart';

part 'service_example.chopper.dart';

@ChopperApi()
abstract class ServiceExample extends ChopperService {
  static ServiceExample create([ChopperClient? client]) =>
      _$ServiceExample(client);

  @Get(path: '/example-api/v1/text')
  Future<Response> getTest();
}
