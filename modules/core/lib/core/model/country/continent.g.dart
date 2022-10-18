// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'continent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Continent _$ContinentFromJson(Map<String, dynamic> json) => Continent(
      code: json['code'] as String,
      name: json['name'] as String,
      countries: (json['countries'] as List<dynamic>)
          .map((e) => Country.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContinentToJson(Continent instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'countries': instance.countries,
    };
