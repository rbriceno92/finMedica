enum Build { dev, staging, qa, production }

class BuildEnvironment {
  final String baseUrl;
  final Build build;

  BuildEnvironment({required this.baseUrl, required this.build});
}

class ConfigurationBuild {
  final BuildEnvironment buildEnvironment;
  static late ConfigurationBuild _instance;

  factory ConfigurationBuild({required BuildEnvironment buildEnvironment}) {
    _instance = ConfigurationBuild._internal(buildEnvironment);
    return _instance;
  }

  factory ConfigurationBuild.develop() {
    return _instance = ConfigurationBuild._internal(BuildEnvironment(
        baseUrl: 'https://finmedica-dev.teravisiontech.cloud/api/',
        build: Build.dev));
  }

  factory ConfigurationBuild.qa() {
    return _instance = ConfigurationBuild._internal(BuildEnvironment(
        baseUrl: 'https://finmedica-qa.teravisiontech.cloud/api/',
        build: Build.qa));
  }

  factory ConfigurationBuild.staging() {
    return _instance = ConfigurationBuild._internal(BuildEnvironment(
        baseUrl: 'https://stage.finmedica.com.mx/api/', build: Build.staging));
  }

  factory ConfigurationBuild.production() {
    return _instance = ConfigurationBuild._internal(BuildEnvironment(
        baseUrl: 'https://finmedica-dev.teravisiontech.cloud/api/',
        build: Build.production));
  }

  static ConfigurationBuild get instance {
    return _instance;
  }

  ConfigurationBuild._internal(this.buildEnvironment);

  static bool isProduction() =>
      _instance.buildEnvironment.build == Build.production;

  static bool isQa() => _instance.buildEnvironment.build == Build.qa;

  static bool isStaging() => _instance.buildEnvironment.build == Build.staging;

  static bool isDevelop() => _instance.buildEnvironment.build == Build.dev;
}
