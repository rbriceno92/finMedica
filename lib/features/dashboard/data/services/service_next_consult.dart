import 'package:app/features/dashboard/data/models/next_consults_request.dart';
import 'package:chopper/chopper.dart';

part 'service_next_consult.chopper.dart';

@ChopperApi()
abstract class ServiceNextConsult extends ChopperService {
  static ServiceNextConsult create([ChopperClient? client]) =>
      _$ServiceNextConsult(client);

  @Post(path: 'account/next_consults')
  Future<Response> getNextConsults(
      @Body() NextConsultRequest nextConsultRequest,
      @Header('Authorization') String token);
}
