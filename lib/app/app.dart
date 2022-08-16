import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weatherapp/app/global_bloc_provider/global_bloc_provider.dart';
import 'package:weatherapp/app/router/app_router.dart';


class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoRouter appRouter = getRouter();
    return MultiBlocProvider(
      providers: getGlobalScopedBlocProvider(),
      child: MaterialApp.router(
        routerDelegate: appRouter.routerDelegate,
        routeInformationParser: appRouter.routeInformationParser,
      ),
    );
  }
}