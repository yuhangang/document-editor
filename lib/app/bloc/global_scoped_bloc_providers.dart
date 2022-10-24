import 'package:core/core/commons/app_env.dart';
import 'package:core/core/di/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/presentation/bloc/city_bloc/city_bloc.dart';
import 'package:weatherapp/presentation/bloc/current_weather_bloc/current_weather_bloc.dart';
import 'package:weatherapp/presentation/bloc/document_list/document_list_bloc.dart';
import 'package:weatherapp/presentation/bloc/location/location_bloc.dart';
import 'package:weatherapp/presentation/bloc/setting/setting_bloc.dart';
import 'package:weatherapp/presentation/bloc/weather_forecast_bloc/weather_forecast_bloc.dart';

List<BlocProvider> getGlobalScopedBlocProvider() => [
      BlocProvider<LocationBloc>(
        create: (_) => sl.get<LocationBloc>(),
      ),
      BlocProvider<WeatherForecastBloc>(
        create: (_) => sl.get<WeatherForecastBloc>(
            param1: sl.get<AppEnv>().defaultLocation),
      ),
      BlocProvider<CityBloc>(
        create: (_) => sl.get<CityBloc>(),
      ),
      BlocProvider<CurrentWeatherBloc>(
        create: (_) => sl.get<CurrentWeatherBloc>(),
      ),
      BlocProvider<SettingBloc>(
        create: (_) => sl.get<SettingBloc>(),
      ),
      BlocProvider<DocumentListBloc>(
        create: (_) => sl.get<DocumentListBloc>(),
      )
    ];
