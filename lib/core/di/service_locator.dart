import 'dart:async';
import 'package:core/core/commons/utils/service/location/i_location_service.dart';
import 'package:core/core/model/model.dart';
import 'package:core/core/repository/i_city_repository.dart';
import 'package:core/core/repository/i_forecast_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:weatherapp/core/navigation/router/app_router.dart';
import 'package:weatherapp/presentation/bloc/city_bloc/city_bloc.dart';
import 'package:weatherapp/presentation/bloc/current_weather_bloc/current_weather_bloc.dart';
import 'package:core/core/commons/app_env.dart';
import 'package:weatherapp/presentation/bloc/weather_forecast_bloc/weather_forecast_bloc.dart';
import 'package:dartz/dartz.dart';

Future<void> configureAppServiceLocator(GetIt sl, AppEnv env) async {
  sl.registerFactory<AppRouter>(() => AppRouter());
  sl.registerSingleton<CityBloc>(CityBloc(
    sl.get<ICityRepository>(),
  ));
  sl.registerSingleton<CurrentWeatherBloc>(
    CurrentWeatherBloc(
         left(env.defaultLocation),
         sl.get<ILocationService>(),
        sl.get<IForecastRepository>(),sl.get<ICityRepository>(),sl.get<CityBloc>())
  );
  sl.registerFactoryParam<WeatherForecastBloc, Coord, void>(
    (coord, _) => WeatherForecastBloc(coord, sl.get<IForecastRepository>()),
  );

}
