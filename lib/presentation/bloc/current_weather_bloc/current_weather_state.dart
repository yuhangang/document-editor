part of 'current_weather_bloc.dart';

extension on Either<Coord, MalaysianCity> {
  Coord get coord {
    return fold((l) => l, (r) => r.coord);
  }
}

abstract class CurrentWeatherState extends Equatable {
  final Either<Coord, MalaysianCity>? location;
  const CurrentWeatherState(
    this.location,
  );

  @override
  List<Object> get props => [location ?? []];
}

class CurrentWeatherInitial extends CurrentWeatherState {
  const CurrentWeatherInitial(super.location);
}

class CurrentWeatherLoading extends CurrentWeatherState {
  const CurrentWeatherLoading(super.location);
}

class CurrentWeatherFailed extends CurrentWeatherState {
  final Exception exception;
  const CurrentWeatherFailed(
    super.location, {
    required this.exception,
  });
}

class CurrentWeatherDoneLoad extends CurrentWeatherState {
  final CurrentWeather weather;
  const CurrentWeatherDoneLoad(
    super.location, {
    required this.weather,
  });
}

class CurrentWeatherDoneRefresh extends CurrentWeatherDoneLoad {
  const CurrentWeatherDoneRefresh(
    super.location, {
    required super.weather,
  });
}
