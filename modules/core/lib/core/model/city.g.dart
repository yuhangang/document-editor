// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MalaysianCityAdapter extends TypeAdapter<MalaysianCity> {
  @override
  final int typeId = 0;

  @override
  MalaysianCity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MalaysianCity(
      city: fields[0] as String,
      lat: fields[1] as String,
      lng: fields[2] as String,
      country: fields[3] as String,
      iso2: fields[4] as String,
      adminName: fields[5] as String,
      capital: fields[6] as String,
      population: fields[7] as String,
      populationProper: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MalaysianCity obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.city)
      ..writeByte(1)
      ..write(obj.lat)
      ..writeByte(2)
      ..write(obj.lng)
      ..writeByte(3)
      ..write(obj.country)
      ..writeByte(4)
      ..write(obj.iso2)
      ..writeByte(5)
      ..write(obj.adminName)
      ..writeByte(6)
      ..write(obj.capital)
      ..writeByte(7)
      ..write(obj.population)
      ..writeByte(8)
      ..write(obj.populationProper);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MalaysianCityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
