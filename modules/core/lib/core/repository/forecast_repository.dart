import 'package:core/core/api/i_open_weather_api_provider.dart';
import 'package:core/core/model/model.dart';
import 'package:core/core/repository/i_forecast_repository.dart';
import 'package:dartz/dartz.dart';

class ForecastRepository implements IForecastRepository {
  IOpenWeatherApiProvider apiProvider;
  ForecastRepository({
    required this.apiProvider,
  });
  @override
  Future<Either<Exception, CurrentWeather>> getCurrentWeatherByCoordinate({required Coord coord}) {
    // TODO: implement getCurrentWeatherByCoordinate
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, WeatherForecastFiveDay>> getFiveDayWeatherForecastByCoordinate({required Coord coord}) {
    // TODO: implement getFiveDayWeatherForecastByCoordinate
    throw UnimplementedError();
  }

}
