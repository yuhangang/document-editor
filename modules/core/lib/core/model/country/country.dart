import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

//
@JsonSerializable()
class Country {
  final String name;
  final String native;
  final String continent;
  final String capital;

  const Country({
    required this.name,
    required this.native,
    required this.continent,
    required this.capital,
  });

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
