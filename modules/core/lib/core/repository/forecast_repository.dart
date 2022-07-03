import 'dart:developer';

import 'package:core/core/api/i_open_weather_api_provider.dart';
import 'package:core/core/commons/error/exceptions.dart';
import 'package:core/core/model/model.dart';
import 'package:core/core/repository/i_forecast_repository.dart';
import 'package:dartz/dartz.dart';

class ForecastRepository implements IForecastRepository {
  IOpenWeatherApiProvider apiProvider;
  ForecastRepository({
    required this.apiProvider,
  });
  @override
  Future<Either<Exception, CurrentWeather>> getCurrentWeatherByCoordinate({required Coord coord}) async{
    try {
      final data = await apiProvider.getCurrentWeatherByCoordinate(coord: coord);
      return Right(data);
    }
    catch (e){
      return left(e is Exception? e : UnknownException());
    }
  }

  @override
  Future<Either<Exception, WeatherForecastFiveDay>> getFiveDayWeatherForecastByCoordinate({required Coord coord}) async{
      try {
      final data = await apiProvider.getFiveDayWeatherForecastByCoordinate(coord: coord);
      return Right(data);
    }
    catch (e){
      return left(e is Exception? e : UnknownException());
    }
  }

}
