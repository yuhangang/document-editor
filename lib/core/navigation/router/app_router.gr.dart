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
    ForecastCitySelectionPageRoute.name: (routeData) {
      return MaterialPageX<Object?>(
          routeData: routeData, child: const ForecastCitySelectionPage());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig('/#redirect',
            path: '/', redirectTo: 'home', fullMatch: true),
        RouteConfig(HomePageRoute.name, path: 'home'),
        RouteConfig(ForecastCitySelectionPageRoute.name,
            path: 'forecastCitySelection')
      ];
}

/// generated route for
/// [HomePage]
class HomePageRoute extends PageRouteInfo<void> {
  const HomePageRoute() : super(HomePageRoute.name, path: 'home');

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [ForecastCitySelectionPage]
class ForecastCitySelectionPageRoute extends PageRouteInfo<void> {
  const ForecastCitySelectionPageRoute()
      : super(ForecastCitySelectionPageRoute.name,
            path: 'forecastCitySelection');

  static const String name = 'ForecastCitySelectionPageRoute';
}
