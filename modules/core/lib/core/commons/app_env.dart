enum SystemOfUnit { metric, imperial }

abstract class AppEnv {
  final String appName;
  final String apiBaseUrl;

  const AppEnv({
    required this.appName,
    required this.apiBaseUrl,
  });
}

class AppEnvDev extends AppEnv {
  const AppEnvDev()
      : super(
          appName: "Document File",
          apiBaseUrl: "http://localhost:1323",
          // apiBaseUrl: "http://10.0.2.2:1323",
        );
}
