import 'package:bloc/bloc.dart';
import 'package:core/core/model/model.dart';
import 'package:core/core/repository/i_forecast_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

part 'weather_forecast_event.dart';
part 'weather_forecast_state.dart';

class WeatherForecastBloc
    extends Bloc<WeatherForecastEvent, WeatherForecastState> {
  Coord _coord;
  final IForecastRepository _forecastRepository;
  WeatherForecastBloc(
    this._coord,
    this._forecastRepository,
  ) : super(WeatherForecastInitial()) {
    on<OnLoadWeatherForecast>((event, emit) async {
      emit(WeatherForecastLoading());
      final state = await _fetchWeatherForecastBasedOnCoord(
          isRefresh: event.isRefresh);
      emit(state.fold((l) => l, (r) => r));
    });

    on<OnChangeWeatherForecastLocation>((event,emit){
      _coord = event.coord;
      add(OnRefreshWeatherForecast());
    });
  }

  Future<Either<WeatherForecastFailed, WeatherForecastDoneLoad>>
      _fetchWeatherForecastBasedOnCoord(
          {required bool isRefresh}) async {
    final currentWeatherResponse =
        await _forecastRepository.getFiveDayWeatherForecastByCoordinate(coord: _coord);
    return currentWeatherResponse.fold(
        (exception) => left(WeatherForecastFailed(exception: exception)),
        (response) => right(isRefresh
            ? WeatherForecastDoneRefresh(forecast: response)
            : WeatherForecastDoneLoad(forecast: response)));
  }

}
