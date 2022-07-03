import 'package:core/core/model/model.dart';

enum SystemOfUnit { metric, imperial }

abstract class AppEnv {
  final String appName;
  final String openWeatherApiBaseUrl;
  final String openWeatherApiKey;
  final String cityListJsonApiRoute;
  final Coord defaultLocation;
  final List<String> defaultSelectedForecastCity;
  final String defaultCurrentWeatherCity;

  AppEnv(
      {required this.appName,
      required this.openWeatherApiBaseUrl,
      required this.openWeatherApiKey,
      required this.cityListJsonApiRoute,
      required this.defaultLocation,
      required this.defaultSelectedForecastCity,
      required this.defaultCurrentWeatherCity});
}

class AppEnvDev extends AppEnv {
  AppEnvDev()
      : super(
            appName: "Weather App",
            openWeatherApiBaseUrl: "https://api.openweathermap.org/data/2.5",
            openWeatherApiKey: "0ac2d1064821d2cdaf995d110e685263",
            cityListJsonApiRoute:
                "https://simplemaps.com/static/data/country-cities/my/my.json",
            defaultLocation: const Coord(lon: 101.6953, lat: 3.1478),
            defaultSelectedForecastCity: [
              'kuala lumpur',
              'johor bahru',
              'george town'
            ],
            defaultCurrentWeatherCity: 'kuala lumpur');
}
