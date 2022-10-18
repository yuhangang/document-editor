// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      code: json['code'] as String,
      name: json['name'] as String,
      native: json['native'] as String,
      continentID: json['continentID'] as String,
      capital: json['capital'] as String,
      cities: (json['cities'] as List<dynamic>)
          .map((e) => WorldCity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'native': instance.native,
      'continentID': instance.continentID,
      'capital': instance.capital,
      'cities': instance.cities,
    };
