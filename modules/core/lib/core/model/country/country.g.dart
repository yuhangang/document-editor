// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      name: json['name'] as String,
      native: json['native'] as String,
      phone: (json['phone'] as List<dynamic>).map((e) => e as int).toList(),
      continent: json['continent'] as String,
      capital: json['capital'] as String,
      currency:
          (json['currency'] as List<dynamic>).map((e) => e as int).toList(),
      languages:
          (json['languages'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'name': instance.name,
      'native': instance.native,
      'phone': instance.phone,
      'continent': instance.continent,
      'capital': instance.capital,
      'currency': instance.currency,
      'languages': instance.languages,
    };
