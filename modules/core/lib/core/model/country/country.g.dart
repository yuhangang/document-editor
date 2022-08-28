// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      code: json['code'] as String,
      name: json['name'] as String,
      native: json['native'] as String,
      continent: json['continent'] as String,
      capital: json['capital'] as String,
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'native': instance.native,
      'continent': instance.continent,
      'capital': instance.capital,
    };
