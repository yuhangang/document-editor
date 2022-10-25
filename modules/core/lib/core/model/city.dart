import 'package:core/core/model/location.dart';
import 'package:core/core/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MalaysianCity extends WeatherLocation {
  final String city;
  final String lat;
  final String lng;
  final String country;
  final String iso2;
  final String adminName;
  final String capital;
  final String population;
  final String populationProper;

  const MalaysianCity(
      {required this.city,
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

  @override
  Coord get coord =>
      Coord(lon: double.tryParse(lng) ?? 0, lat: double.tryParse(lat) ?? 0);

  @override
  List<Object?> get props => [city, coord];
}
