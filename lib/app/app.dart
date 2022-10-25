import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:documenteditor/app/bloc/global_scoped_bloc_providers.dart';
import 'package:documenteditor/app/router/app_router.dart';

final GoRouter appRouter = getRouter();

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: getGlobalScopedBlocProvider(),
      child: MaterialApp.router(
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.blueAccent, elevation: 0),
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                titleTextStyle: TextStyle(color: Colors.blueGrey, fontSize: 20),
                systemOverlayStyle: SystemUiOverlayStyle.dark,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black))),
        routerDelegate: appRouter.routerDelegate,
        routeInformationParser: appRouter.routeInformationParser,
      ),
    );
  }
}
