import 'dart:io';

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
  AppEnvDev()
      : super(
          appName: "Document File",
          apiBaseUrl: Platform.isAndroid
              ? "http://192.168.0.6:1323"
              : "http://localhost:1323",
          // apiBaseUrl: "http://10.0.2.2:1323",
        );
}
