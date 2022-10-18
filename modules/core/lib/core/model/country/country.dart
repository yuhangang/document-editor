import 'package:core/core/model/country/world_city.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

//
@JsonSerializable()
class Country {
  final String code;
  final String name;
  final String native;
  final String continentID;
  final String capital;
  final List<WorldCity> cities;

  const Country(
      {required this.code,
      required this.name,
      required this.native,
      required this.continentID,
      required this.capital,
      required this.cities});

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
