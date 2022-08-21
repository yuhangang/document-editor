import 'package:json_annotation/json_annotation.dart';

part 'world_city.g.dart';

//
@JsonSerializable()
class WorldCity {
  final String name;
  final String country;
  final String lat;
  final String lng;

  const WorldCity({
    required this.name,
    required this.country,
    required this.lat,
    required this.lng,
  });

  factory WorldCity.fromJson(Map<String, dynamic> json) =>
      _$WorldCityFromJson(json);
  Map<String, dynamic> toJson() => _$WorldCityToJson(this);
}
