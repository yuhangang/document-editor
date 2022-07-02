import 'package:core/core/api/i_open_weather_api_provider.dart';
import 'package:core/core/api/open_weather_api_provider.dart';
import 'package:core/core/commons/app_env.dart';
import 'package:core/core/repository/forecast_repository.dart';
import 'package:core/core/repository/i_forecast_repository.dart';
import 'package:core/network/dio_network_client.dart';
import 'package:core/network/i_network_client.dart';
import 'package:core/network/options.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> configureCoreServiceLocator(AppEnv env) async {
  //Because we do injection on didChangeDependencies in MainApp, so every time state from InheritedWidget changes,
  //it will trigger to run the injection again, it will return warning because we already injected before,
  //this if for prevent the warning messages.

     sl.registerSingleton<INetworkClient>(DioNetworkClient(BaseNetworkOptions(baseUrl: env.openWeatherApiBaseUrl)));
     sl.registerSingleton<IOpenWeatherApiProvider>( OpenWeatherApiProvider(client:sl.get<INetworkClient>(),appEnv: env));
     sl.registerSingleton<IForecastRepository>(ForecastRepository(apiProvider: sl.get<IOpenWeatherApiProvider>()));
  }