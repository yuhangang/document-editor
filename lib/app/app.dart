import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weatherapp/app/bloc/global_scoped_bloc_providers.dart';
import 'package:weatherapp/app/router/app_router.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoRouter appRouter = getRouter();
    return MultiBlocProvider(
      providers: getGlobalScopedBlocProvider(),
      child: MaterialApp.router(
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                systemOverlayStyle: SystemUiOverlayStyle.dark,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black))),
        routerDelegate: appRouter.routerDelegate,
        routeInformationParser: appRouter.routeInformationParser,
      ),
    );
  }
}
