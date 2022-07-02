import 'package:core/core/model/model.dart';
import 'package:dartz/dartz.dart';

abstract class IForecastRepository {
  Future<Either<Exception,CurrentWeather>> getCurrentWeatherByCoordinate({required Coord coord});
   Future<Either<Exception,WeatherForecastFiveDay>> getFiveDayWeatherForecastByCoordinate({required Coord coord});
}