part of 'current_weather_bloc.dart';

abstract class CurrentWeatherEvent extends Equatable {
  const CurrentWeatherEvent();
  @override
  List<Object> get props => [];
}

class OnLoadCurrentWeather extends CurrentWeatherEvent {

  bool get isRefresh => false;
}

class OnRefreshCurrentWeather extends OnLoadCurrentWeather {

  @override
  bool get isRefresh => true;
}

class OnChangeCurrentWeatherCity extends CurrentWeatherEvent{
  final MalaysianCity city;

  const OnChangeCurrentWeatherCity({
    required this.city,
  });
}
class OnChangeCurrentWeatherToUserCurrentLocation extends CurrentWeatherEvent{}
