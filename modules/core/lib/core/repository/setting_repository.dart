import 'package:core/core/api/user_api_provider.dart';
import 'package:core/core/commons/utils/device/device_info_utils.dart';
import 'package:core/core/commons/utils/service/location/i_location_service.dart';
import 'package:core/core/model/device_info.dart';
import 'package:dartz/dartz.dart';

abstract class SettingRepository {
  Future<Either<Exception, DeviceInfo>> getDeviceInfo();
}

class SettingRepositoryImpl implements SettingRepository {
  final IDeviceInfoUtils deviceInfoUtils;
  final ILocationService locationService;
  final UserApiProvider userApiProvider;
  SettingRepositoryImpl(
      {required this.deviceInfoUtils,
      required this.userApiProvider,
      required this.locationService});

  @override
  Future<Either<Exception, DeviceInfo>> getDeviceInfo() async {
    try {
      final locationData = await locationService.getLocation();
      final deviceInfo = DeviceInfo(
          deviceId: await deviceInfoUtils.getDeviceId(),
          deviceManufacturer: await deviceInfoUtils.getDeviceManufacturer(),
          deviceModel: await deviceInfoUtils.getDeviceModel(),
          deviceOsVersion: await deviceInfoUtils.getDeviceModel(),
          deviceOsVersionNumber:
              await deviceInfoUtils.getDeviceOsVersionNumber(),
          lat: locationData.latitude,
          lng: locationData.longitude);
      final response = await userApiProvider.submitDeviceInfo(deviceInfo);
      return right(response);
    } on Exception catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
