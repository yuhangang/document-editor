import 'package:core/core/model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';
import 'package:storage/config/storage_config.dart';

part 'city.g.dart';

@HiveType(typeId: HiveTypeId.malaysianCity)
@JsonSerializable(fieldRename: FieldRename.snake)
class MalaysianCity extends Equatable{
  @HiveField(0)
  final String city;
  @HiveField(1)
  final String lat;
  @HiveField(2)
  final String lng;
  @HiveField(3)
  final String country;
  @HiveField(4)
  final String iso2;
  @HiveField(5)
  final String adminName;
  @HiveField(6)
  final String capital;
  @HiveField(7)
  final String population;
  @HiveField(8)
  final String populationProper;

  const MalaysianCity(
    { required this.city,
      required this.lat,
      required this.lng,
      required this.country,
      required this.iso2,
      required this.adminName,
      required this.capital,
      required this.population,
      required this.populationProper});

     factory MalaysianCity.fromJson(Map<String, dynamic> json) =>
      _$MalaysianCityFromJson(json);
  Map<String, dynamic> toJson() => _$MalaysianCityToJson(this);

  Coord get coord=>Coord(lon: double.tryParse(lng)?? 0, lat: double.tryParse(lat) ?? 0);
  
  @override
  // TODO: implement props
  List<Object?> get props => [city];
}