import 'package:chopper/chopper.dart';

part 'service_terms_conditions.chopper.dart';

@ChopperApi()
abstract class ServiceTermsConditions extends ChopperService {
  static ServiceTermsConditions create([ChopperClient? client]) =>
      _$ServiceTermsConditions(client);

  @Get(path: 'general/terms_conditions')
  Future<Response> termsConditions();
}
