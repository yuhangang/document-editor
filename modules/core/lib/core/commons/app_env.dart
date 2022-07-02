enum SystemOfUnit { metric, imperial }

abstract class AppEnv {
  final String appName;
  final String openWeatherApiBaseUrl;
  final String openWeatherApiKey;
  AppEnv({
    required this.appName,
    required this.openWeatherApiBaseUrl,
    required this.openWeatherApiKey,
  });
}

class AppEnvDev extends AppEnv {
  AppEnvDev()
      : super(
            appName: "Weather App",
            openWeatherApiBaseUrl: "https://api.openweathermap.org/data/2.5/",
            openWeatherApiKey: "");
}

