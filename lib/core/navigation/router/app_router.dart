import 'package:auto_route/auto_route.dart';
import 'package:core/core/model/model.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/core/navigation/path/app_path.dart' as app_path;
import 'package:weatherapp/presentation/widget/home_page.dart';
import 'package:weatherapp/presentation/widget/setting_page.dart';
part 'app_router.gr.dart';


@MaterialAutoRouter(
  routes : <AutoRoute>[
AutoRoute<Object?>(
      path: app_path.home,
      page: HomePage,
      initial: true
    ),
AutoRoute<Object?>(
      path: app_path.setting,
      page: SettingPage,
    ),
  ]
)

class AppRouter extends _$AppRouter {}