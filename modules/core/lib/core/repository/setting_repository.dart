class DeviceInfo {
  final String deviceId;
  final String deviceManufacturer;
  final String deviceModel;
  final String deviceOsVersion;
  final String deviceOsVersionNumber;
  final double? lat;
  final double? lng;
  DeviceInfo({
    required this.deviceId,
    required this.deviceManufacturer,
    required this.deviceModel,
    required this.deviceOsVersion,
    required this.deviceOsVersionNumber,
    this.lat,
    this.lng,
  }) : assert((lat != null && lng != null) || (lat == null && lng == null));
}

abstract class SettingRepository {}
