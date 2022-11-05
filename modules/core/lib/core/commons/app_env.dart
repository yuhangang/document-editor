import 'package:core/core/model/model.dart';

enum SystemOfUnit { metric, imperial }

abstract class AppEnv {
  final String appName;
  final String apiBaseUrl;
  final String openWeatherApiKey;
  final String cityListJsonApiRoute;
  final Coord defaultLocation;
  final List<String> defaultSelectedForecastCity;
  final String defaultCurrentWeatherCity;

  const AppEnv(
      {required this.appName,
      required this.apiBaseUrl,
      required this.openWeatherApiKey,
      required this.cityListJsonApiRoute,
      required this.defaultLocation,
      required this.defaultSelectedForecastCity,
      required this.defaultCurrentWeatherCity});
}

class AppEnvDev extends AppEnv {
  const AppEnvDev()
      : super(
            appName: "Weather App",
            apiBaseUrl: "http://localhost:1323",
            // apiBaseUrl: "http://10.0.2.2:1323",
            openWeatherApiKey: "0ac2d1064821d2cdaf995d110e685263",
            cityListJsonApiRoute:
                "https://simplemaps.com/static/data/country-cities/my/my.json",
            defaultLocation: const Coord(lon: 101.6953, lat: 3.1478),
            defaultSelectedForecastCity: const [
              'kuala lumpur',
              'johor bahru',
              'george town'
            ],
            defaultCurrentWeatherCity: 'kuala lumpur');
}
