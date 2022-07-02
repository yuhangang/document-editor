import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';



@JsonSerializable(fieldRename: FieldRename.snake)
class CurrentWeather{
  final Coord coord;
  final List<Weather> weather;
  final String base;
  final CurrentWeatherMainData main;
  final int visibility;
  final Wind wind;
  final Clouds clouds;
  final int dt;
  final Sys sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  CurrentWeather(
      {required this.coord,
      required this.weather,
      required this.base,
      required this.main,
      required this.visibility,
      required this.wind,
      required this.clouds,
      required this.dt,
      required this.sys,
      required this.timezone,
      required this.id,
      required this.name,
      required this.cod});

    factory CurrentWeather.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherFromJson(json);
  Map<String, dynamic> toJson() => _$CurrentWeatherToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Coord  {
  final double lon;
  final double lat;
  Coord({
    required this.lon,
    required this.lat,
  });
  factory Coord.fromJson(Map<String, dynamic> json) =>
      _$CoordFromJson(json);
  Map<String, dynamic> toJson() => _$CoordToJson(this);

}

@JsonSerializable(fieldRename: FieldRename.snake)
class CurrentWeatherMainData {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;

  CurrentWeatherMainData(
      {required this.temp,
      required this.feelsLike,
      required this.tempMin,
      required this.tempMax,
      required this.pressure,
      required this.humidity});
    factory CurrentWeatherMainData.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherMainDataFromJson(json);
  Map<String, dynamic> toJson() => _$CurrentWeatherMainDataToJson(this);
}


@JsonSerializable(fieldRename: FieldRename.snake)
class Clouds {
  final int all;

  Clouds({required this.all});
    factory Clouds.fromJson(Map<String, dynamic> json) =>
      _$CloudsFromJson(json);
  Map<String, dynamic> toJson() => _$CloudsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Sys {
  final int type;
  final int id;
  final double message;
  final String country;
  final int sunrise;
  final int sunset;

  Sys(
      {required this.type,
      required this.id,
      required this.message,
      required this.country,
      required this.sunrise,
      required this.sunset});
      factory Sys.fromJson(Map<String, dynamic> json) =>
      _$SysFromJson(json);
  Map<String, dynamic> toJson() => _$SysToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class WeatherForecastFiveDay {
  final String cod;
  final int message;
  final int cnt;
  final List<WeatherForecast> list;
  final City city;

  WeatherForecastFiveDay({required this.cod, required this.message,required this.cnt,required this.list,required this.city});
    factory WeatherForecastFiveDay.fromJson(Map<String, dynamic> json) =>
      _$WeatherForecastFiveDayFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherForecastFiveDayToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class WeatherForecast {
  final int dt;
  final ForecastMainData main;
  final List<Weather> weather;
  final Clouds clouds;
  final Wind wind;
  final int visibility;
  final int pop;
  final ForecastSys sys;
  final String dtTxt;

  WeatherForecast(
    { required this.dt,
      required this.main,
      required this.weather,
      required this.clouds,
      required this.wind,
      required this.visibility,
      required this.pop,
      required this.sys,
      required this.dtTxt});

    factory WeatherForecast.fromJson(Map<String, dynamic> json) =>
      _$WeatherForecastFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherForecastToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ForecastMainData {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int seaLevel;
  final int grndLevel;
  final int humidity;
  final double tempKf;

  ForecastMainData(
     {required this.temp,
      required this.feelsLike,
      required this.tempMin,
      required this.tempMax,
      required this.pressure,
      required this.seaLevel,
      required this.grndLevel,
      required this.humidity,
      required this.tempKf});
        factory ForecastMainData.fromJson(Map<String, dynamic> json) =>
      _$ForecastMainDataFromJson(json);
  Map<String, dynamic> toJson() => _$ForecastMainDataToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather({required this.id, required this.main,required this.description,required this.icon});
    factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Wind {
  final double speed;
  final int deg;
  final double? gust;
  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

    factory Wind.fromJson(Map<String, dynamic> json) =>
      _$WindFromJson(json);
  Map<String, dynamic> toJson() => _$WindToJson(this);


}

@JsonSerializable(fieldRename: FieldRename.snake)
class ForecastSys {
  final String pod;

  ForecastSys({required this.pod});

    factory ForecastSys.fromJson(Map<String, dynamic> json) =>
      _$ForecastSysFromJson(json);
  Map<String, dynamic> toJson() => _$ForecastSysToJson(this);

}

@JsonSerializable(fieldRename: FieldRename.snake)
class City {
  final int id;
  final String name;
  final Coord coord;
  final String country;
  final int population;
  final int timezone;
  final int sunrise;
  final int sunset;

  City(
    {required this.id,
     required  this.name,
     required  this.coord,
     required  this.country,
     required  this.population,
     required  this.timezone,
     required  this.sunrise,
     required  this.sunset});
  factory City.fromJson(Map<String, dynamic> json) =>
      _$CityFromJson(json);
  Map<String, dynamic> toJson() => _$CityToJson(this);
}