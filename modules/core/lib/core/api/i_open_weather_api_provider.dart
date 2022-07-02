import 'package:core/core/model/model.dart';

abstract class IOpenWeatherApiProvider{
  Future<CurrentWeather> getCurrentWeatherByCoordinate({required Coord coord});

  Future<WeatherForecastFiveDay> getFiveDayWeatherForecastByCoordinate({required Coord coord});
}