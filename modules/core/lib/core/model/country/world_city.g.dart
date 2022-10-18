// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'world_city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorldCity _$WorldCityFromJson(Map<String, dynamic> json) => WorldCity(
      id: json['id'] as int,
      name: json['name'] as String,
      countryID: json['countryID'] as String,
      capital: json['capital'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$WorldCityToJson(WorldCity instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'countryID': instance.countryID,
      'capital': instance.capital,
      'lat': instance.lat,
      'lng': instance.lng,
    };
