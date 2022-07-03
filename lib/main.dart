import 'package:core/core/commons/app_env.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weatherapp/core/di/service_locator.dart';
import 'package:weatherapp/core/navigation/router/app_router.dart';
import 'package:core/core/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
   await configureCoreServiceLocator(AppEnvDev(),
      initializeFunctions: [configureAppServiceLocator]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _appRouter = sl.get<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
