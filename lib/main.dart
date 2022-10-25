import 'package:core/core/commons/app_env.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:documenteditor/app/app.dart';
import 'package:documenteditor/core/di/service_locator.dart';
import 'package:core/core/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]),
    configureCoreServiceLocator(const AppEnvDev(),
        initializeFunctions: [configureAppServiceLocator])
  ]);

  runApp(const WeatherApp());
}
