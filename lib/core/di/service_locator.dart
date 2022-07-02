import 'dart:async';
import 'package:core/core/model/model.dart';
import 'package:core/core/repository/i_forecast_repository.dart';
import 'package:weatherapp/presentation/bloc/current_weather_bloc/current_weather_bloc.dart';
import 'package:core/core/commons/app_env.dart';
import 'package:core/core/di/service_locator.dart';
import 'package:weatherapp/presentation/bloc/weather_forecast_bloc/weather_forecast_bloc.dart';

 Future<void> configureAppServiceLocator(AppEnv env) async{
  sl.registerFactoryParam<CurrentWeatherBloc, Coord, dynamic>(
    (coord, _) => CurrentWeatherBloc(coord,sl.get<IForecastRepository>()),
  );
    sl.registerFactoryParam<WeatherForecastBloc, Coord, dynamic>(
    (coord, _) => WeatherForecastBloc(coord,sl.get<IForecastRepository>()),
  );
}