part of 'weather_forecast_bloc.dart';

abstract class WeatherForecastEvent extends Equatable {
  const WeatherForecastEvent();
  @override
  List<Object> get props => [];
}

class OnLoadWeatherForecast extends WeatherForecastEvent {
  bool get isRefresh => false;
}

class OnRefreshWeatherForecast extends OnLoadWeatherForecast {
  @override
  bool get isRefresh => true;
}

class OnChangeWeatherForecastLocation extends WeatherForecastEvent {
  final Coord coord;
  const OnChangeWeatherForecastLocation({
    required this.coord,
  });
}
