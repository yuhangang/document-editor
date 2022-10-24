// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) => DeviceInfo(
      deviceId: json['device_id'] as String,
      deviceManufacturer: json['device_manufacturer'] as String,
      deviceModel: json['device_model'] as String,
      deviceOsVersion: json['device_os_version'] as String,
      deviceOsVersionNumber:
          (json['device_os_version_number'] as num).toDouble(),
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DeviceInfoToJson(DeviceInfo instance) =>
    <String, dynamic>{
      'device_id': instance.deviceId,
      'device_manufacturer': instance.deviceManufacturer,
      'device_model': instance.deviceModel,
      'device_os_version': instance.deviceOsVersion,
      'device_os_version_number': instance.deviceOsVersionNumber,
      'lat': instance.lat,
      'lng': instance.lng,
    };
