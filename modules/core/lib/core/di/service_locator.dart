import 'package:core/core/api/city_api_provider.dart';
import 'package:core/core/api/document_api_provider.dart';
import 'package:core/core/api/i_city_api_provider.dart';
import 'package:core/core/api/user_api_provider.dart';
import 'package:core/core/commons/app_env.dart';
import 'package:core/core/commons/utils/device/device_info_utils.dart';
import 'package:core/core/commons/utils/device/device_screen_helpers.dart';
import 'package:core/core/commons/utils/logger/i_logger.dart';
import 'package:core/core/commons/utils/service/location/i_location_service.dart';
import 'package:core/core/commons/utils/service/location/location_service.dart';
import 'package:core/core/model/document.dart';
import 'package:core/core/repository/document_repository.dart';
import 'package:core/core/repository/document_repository_impl.dart';
import 'package:core/core/repository/setting_repository.dart';
import 'package:core/network/dio_network_client.dart';
import 'package:core/network/i_network_client.dart';
import 'package:core/network/options.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:logger/logger.dart';

final sl = GetIt.instance;

Future<void> configureCoreServiceLocator(AppEnv env,
    {List<Future<void> Function(GetIt, AppEnv)> initializeFunctions =
        const []}) async {
  final isar = await Isar.open([DocumentFileSchema]);
  sl.registerSingleton<AppEnv>(env);
  sl.registerSingleton<ILogger>(AppLogger(Logger()));

  sl.registerSingleton<INetworkClient>(
      DioNetworkClient(BaseNetworkOptions(baseUrl: env.apiBaseUrl)));
  sl.registerSingleton<ILocationService>(LocationService());

  sl.registerSingleton<ICityApiProvider>(
      CityApiProvider(client: sl.get<INetworkClient>(), appEnv: env));
  sl.registerFactory<IDeviceInfoUtils>(
      () => DeviceInfoUtils(DeviceInfoPlugin(), DeviceScreenHelper()));
  sl.registerSingleton<UserApiProvider>(
      UserApiProviderImpl(client: sl.get<INetworkClient>(), appEnv: env));
  sl.registerSingleton<DocumentApiProvider>(
      DocumentApiProviderImpl(client: sl.get<INetworkClient>(), appEnv: env));
  sl.registerSingleton<DocumentRepository>(DocumentRepositoryImpl(
      isar: isar, documentApiProvider: sl.get<DocumentApiProvider>()));
  sl.registerSingleton<SettingRepository>(SettingRepositoryImpl(
      userApiProvider: sl.get<UserApiProvider>(),
      locationService: sl.get<ILocationService>(),
      deviceInfoUtils: sl.get<IDeviceInfoUtils>()));
  await Future.forEach<Future<void> Function(GetIt, AppEnv)>(
      initializeFunctions, (initFunction) async {
    await initFunction.call(sl, env);
  });
}
