import 'package:core/core/commons/app_env.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weatherapp/app/app.dart';
import 'package:weatherapp/core/di/service_locator.dart';
import 'package:core/core/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await configureCoreServiceLocator(const AppEnvDev(),
      initializeFunctions: [configureAppServiceLocator]);
  runApp(const WeatherApp());
}
