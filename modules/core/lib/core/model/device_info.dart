import 'package:json_annotation/json_annotation.dart';

part 'device_info.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DeviceInfo {
  final String deviceId;
  final String deviceManufacturer;
  final String deviceModel;
  final String deviceOsVersion;
  final double deviceOsVersionNumber;
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

  factory DeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceInfoToJson(this);
}
