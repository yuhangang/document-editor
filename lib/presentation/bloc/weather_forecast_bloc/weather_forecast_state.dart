part of 'weather_forecast_bloc.dart';

abstract class WeatherForecastState extends Equatable {
  const WeatherForecastState();

  @override
  List<Object> get props => [];
}

class WeatherForecastInitial extends WeatherForecastState {}

class WeatherForecastLoading extends WeatherForecastState {}

class WeatherForecastFailed extends WeatherForecastState {
  final Exception exception;
  const WeatherForecastFailed({
    required this.exception,
  });
}

class WeatherForecastDoneLoad extends WeatherForecastState {
  final WeatherForecastFiveDay forecast;
  const WeatherForecastDoneLoad({
    required this.forecast,
  });
}

class WeatherForecastDoneRefresh extends WeatherForecastDoneLoad {
  const WeatherForecastDoneRefresh({
    required super.forecast,
  });
}
