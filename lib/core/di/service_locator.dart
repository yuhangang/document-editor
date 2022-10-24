import 'dart:async';
import 'package:core/core/commons/utils/service/location/i_location_service.dart';
import 'package:core/core/model/model.dart';
import 'package:core/core/repository/document_repository.dart';
import 'package:core/core/repository/i_city_repository.dart';
import 'package:core/core/repository/i_forecast_repository.dart';
import 'package:core/core/repository/setting_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:weatherapp/presentation/bloc/city_bloc/city_bloc.dart';
import 'package:weatherapp/presentation/bloc/current_weather_bloc/current_weather_bloc.dart';
import 'package:core/core/commons/app_env.dart';
import 'package:weatherapp/presentation/bloc/document_list/document_list_bloc.dart';
import 'package:weatherapp/presentation/bloc/location/location_bloc.dart';
import 'package:weatherapp/presentation/bloc/setting/setting_bloc.dart';
import 'package:weatherapp/presentation/bloc/weather_forecast_bloc/weather_forecast_bloc.dart';
import 'package:dartz/dartz.dart';

Future<void> configureAppServiceLocator(GetIt sl, AppEnv env) async {
  sl.registerFactory<LocationBloc>(
      () => LocationBloc(sl.get<ILocationService>()));

  sl.registerFactory<CityBloc>(() => CityBloc(
        sl.get<ICityRepository>(),
      ));
  sl.registerFactory<CurrentWeatherBloc>(() => CurrentWeatherBloc(
      left(env.defaultLocation),
      sl.get<IForecastRepository>(),
      sl.get<ICityRepository>(),
      sl.get<CityBloc>()));

  sl.registerFactoryParam<WeatherForecastBloc, Coord, void>(
    (coord, _) => WeatherForecastBloc(coord, sl.get<IForecastRepository>()),
  );
  sl.registerFactory<SettingBloc>(
      () => SettingBloc(sl.get<SettingRepository>()));

  sl.registerFactory<DocumentListBloc>(
      () => DocumentListBloc(sl.get<DocumentRepository>()));
}
