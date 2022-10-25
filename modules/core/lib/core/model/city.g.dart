// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MalaysianCity _$MalaysianCityFromJson(Map<String, dynamic> json) =>
    MalaysianCity(
      city: json['city'] as String,
      lat: json['lat'] as String,
      lng: json['lng'] as String,
      country: json['country'] as String,
      iso2: json['iso2'] as String,
      adminName: json['admin_name'] as String,
      capital: json['capital'] as String,
      population: json['population'] as String,
      populationProper: json['population_proper'] as String,
    );

Map<String, dynamic> _$MalaysianCityToJson(MalaysianCity instance) =>
    <String, dynamic>{
      'city': instance.city,
      'lat': instance.lat,
      'lng': instance.lng,
      'country': instance.country,
      'iso2': instance.iso2,
      'admin_name': instance.adminName,
      'capital': instance.capital,
      'population': instance.population,
      'population_proper': instance.populationProper,
    };
