import 'package:core/core/api/city_api_provider.dart';
import 'package:core/core/api/i_city_api_provider.dart';
import 'package:core/core/api/i_open_weather_api_provider.dart';
import 'package:core/core/api/open_weather_api_provider.dart';
import 'package:core/core/commons/app_env.dart';
import 'package:core/core/commons/utils/logger/i_logger.dart';
import 'package:core/core/commons/utils/service/location/i_location_service.dart';
import 'package:core/core/commons/utils/service/location/location_service.dart';
import 'package:core/core/model/city.dart';
import 'package:core/core/model/db_tables/city_table.dart';
import 'package:core/core/model/db_tables/country_table.dart';
import 'package:core/core/repository/city_repository.dart';
import 'package:core/core/repository/forecast_repository.dart';
import 'package:core/core/repository/i_city_repository.dart';
import 'package:core/core/repository/i_forecast_repository.dart';
import 'package:core/network/dio_network_client.dart';
import 'package:core/network/i_network_client.dart';
import 'package:core/network/options.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:storage/core/storage/hive_local_storage.dart';
import 'package:storage/core/storage/i_local_storage.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:storage/db/base/database_helper.dart';

import '../model/db_tables/continent_table.dart';

final sl = GetIt.instance;

Future<void> configureCoreServiceLocator(AppEnv env,
    {List<Future<void> Function(GetIt, AppEnv)> initializeFunctions =
        const []}) async {
  sl.registerSingleton<AppEnv>(env);
  sl.registerSingleton<ILogger>(AppLogger(Logger()));
  sl.registerSingleton<ILocalStorage>(HiveLocalStorage(() {
    Hive.registerAdapter(MalaysianCityAdapter());
  }));
  sl.registerSingleton<ContinentTable>(ContinentTable());
  sl.registerSingleton<CountryTable>(CountryTable());
  sl.registerSingleton<CityTable>(CityTable());
  final dbHelper = DatabaseHelper(tables: [
    sl.get<ContinentTable>(),
    sl.get<CountryTable>(),
    sl.get<CityTable>()
  ]);
  await dbHelper.init();
  sl.registerSingleton<DatabaseHelper>(dbHelper);

  await sl.get<ILocalStorage>().init();
  sl.registerSingleton<INetworkClient>(
      DioNetworkClient(BaseNetworkOptions(baseUrl: env.openWeatherApiBaseUrl)));
  sl.registerSingleton<ILocationService>(LocationService());

  sl.registerSingleton<IOpenWeatherApiProvider>(
      OpenWeatherApiProvider(client: sl.get<INetworkClient>(), appEnv: env));
  sl.registerSingleton<ICityApiProvider>(
      CityApiProvider(client: sl.get<INetworkClient>(), appEnv: env));
  sl.registerSingleton<IForecastRepository>(
      ForecastRepository(apiProvider: sl.get<IOpenWeatherApiProvider>()));
  sl.registerSingleton<ICityRepository>(CityRepository(
      cityApiProvider: sl.get<ICityApiProvider>(),
      localStorage: sl.get<ILocalStorage>()));

  await Future.forEach<Future<void> Function(GetIt, AppEnv)>(
      initializeFunctions, (initFunction) async {
    await initFunction.call(sl, env);
  });
}
