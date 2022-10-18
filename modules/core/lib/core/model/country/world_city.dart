import 'package:json_annotation/json_annotation.dart';

part 'world_city.g.dart';

//
@JsonSerializable()
class WorldCity {
  final int id;
  final String name;
  final String countryID;
  final String capital;
  final double lat;
  final double lng;

  const WorldCity({
    required this.id,
    required this.name,
    required this.countryID,
    required this.capital,
    required this.lat,
    required this.lng,
  });

  factory WorldCity.fromJson(Map<String, dynamic> json) =>
      _$WorldCityFromJson(json);
  Map<String, dynamic> toJson() => _$WorldCityToJson(this);
}
