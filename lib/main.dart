import 'package:core/core/commons/app_env.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weatherapp/core/di/service_locator.dart';
import 'package:weatherapp/core/navigation/router/app_router.dart';
import 'package:core/core/di/service_locator.dart';
import 'package:weatherapp/presentation/bloc/city_bloc/city_bloc.dart';
import 'package:weatherapp/presentation/bloc/current_weather_bloc/current_weather_bloc.dart';
import 'package:weatherapp/presentation/bloc/weather_forecast_bloc/weather_forecast_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await configureCoreServiceLocator(const AppEnvDev(),
      initializeFunctions: [configureAppServiceLocator]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoRouter appRouter = getRouter();
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherForecastBloc>(
          create: (_) => sl.get<WeatherForecastBloc>(
              param1: sl.get<AppEnv>().defaultLocation),
        ),
        BlocProvider<CityBloc>(
          create: (_) => sl.get<CityBloc>(),
        ),
        BlocProvider<CurrentWeatherBloc>(
          create: (_) => sl.get<CurrentWeatherBloc>(),
        )
      ],
      child: MaterialApp.router(
        routerDelegate: appRouter.routerDelegate,
        routeInformationParser: appRouter.routeInformationParser,
      ),
    );
  }
}
