import 'package:core/core/model/country/country.dart';
import 'package:json_annotation/json_annotation.dart';

part 'continent.g.dart';

@JsonSerializable()
class Continent {
  final String code;
  final String name;
  final List<Country> countries;

  const Continent(
      {required this.code, required this.name, required this.countries});

  factory Continent.fromJson(Map<String, dynamic> json) =>
      _$ContinentFromJson(json);
  Map<String, dynamic> toJson() => _$ContinentToJson(this);
}
