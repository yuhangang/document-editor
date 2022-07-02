part of 'current_weather_bloc.dart';

abstract class CurrentWeatherState extends Equatable {
  const CurrentWeatherState();
  
  @override
  List<Object> get props => [];
}

class CurrentWeatherInitial extends CurrentWeatherState {}

class CurrentWeatherLoading extends CurrentWeatherState {}

class CurrentWeatherFailed extends CurrentWeatherState {
  final Exception exception;
  const CurrentWeatherFailed({
    required this.exception,
  });
}

class CurrentWeatherDoneLoad extends CurrentWeatherState {
  final CurrentWeather weather;
  const CurrentWeatherDoneLoad({
    required this.weather,
  });
}

class CurrentWeatherDoneRefresh extends CurrentWeatherDoneLoad {
   const CurrentWeatherDoneRefresh({
    required super.weather,
  });
}