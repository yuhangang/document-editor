import 'package:go_router/go_router.dart';
import 'package:weatherapp/core/navigation/path/app_path.dart' as app_path;
import 'package:weatherapp/presentation/widget/home/forecast_city_selection_page.dart';
import 'package:weatherapp/presentation/widget/home/home_page.dart';

GoRouter getRouter() => GoRouter(routes: [
      GoRoute(
          path: app_path.home,
          builder: (context, state) => const HomePage()),
      GoRoute(
          path: app_path.forecastCitySelection,
          builder: (context, state) => const ForecastCitySelectionPage())
    ]);
