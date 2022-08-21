import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

//
@JsonSerializable()
class Country {
  final String name;
  final String native;
  final List<int> phone;
  final String continent;
  final String capital;
  final List<int> currency;
  final List<String> languages;

  const Country({
    required this.name,
    required this.native,
    required this.phone,
    required this.continent,
    required this.capital,
    required this.currency,
    required this.languages,
  });

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
