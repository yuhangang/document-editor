// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    HomePageRoute.name: (routeData) {
      return MaterialPageX<Object?>(
          routeData: routeData, child: const HomePage());
    },
    SettingPageRoute.name: (routeData) {
      return MaterialPageX<Object?>(
          routeData: routeData, child: const SettingPage());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig('/#redirect',
            path: '/', redirectTo: 'home', fullMatch: true),
        RouteConfig(HomePageRoute.name, path: 'home'),
        RouteConfig(SettingPageRoute.name, path: 'setting')
      ];
}

/// generated route for
/// [HomePage]
class HomePageRoute extends PageRouteInfo<void> {
  const HomePageRoute() : super(HomePageRoute.name, path: 'home');

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [SettingPage]
class SettingPageRoute extends PageRouteInfo<void> {
  const SettingPageRoute() : super(SettingPageRoute.name, path: 'setting');

  static const String name = 'SettingPageRoute';
}
