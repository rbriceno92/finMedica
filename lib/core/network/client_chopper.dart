import 'package:app/core/builds/build_environment.dart';
import 'package:app/core/network/refresh_token_interceptor.dart';
import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;

class ClientChopper {
  static ChopperClient buildClientChopper(List<ChopperService> services,
          http.BaseClient? client, ChopperRefreshAutenticator? authenticator) =>
      ChopperClient(
          baseUrl:
              Uri.parse(ConfigurationBuild.instance.buildEnvironment.baseUrl),
          client: client,
          services: services,
          converter: const JsonConverter(),
          errorConverter: const JsonConverter(),
          authenticator: authenticator);
}
