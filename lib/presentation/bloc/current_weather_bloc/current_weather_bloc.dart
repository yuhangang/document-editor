import 'package:bloc/bloc.dart';
import 'package:core/core/model/model.dart';
import 'package:core/core/repository/i_forecast_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  Coord _coord;
  final IForecastRepository _forecastRepository;
  CurrentWeatherBloc(
    this._coord,
    this._forecastRepository,
  ) : super(CurrentWeatherInitial()) {
    on<OnLoadCurrentWeather>((event, emit) async {
      emit(CurrentWeatherLoading());
      final state =
          await _fetchCurrentWeatherBasedOnCoord(isRefresh: event.isRefresh);
      emit(state.fold((l) => l, (r) => r));
    });
    
    on<OnChangeCurrentWeatherLocation>((event, emit) {
      _coord = event.coord;
      add(OnRefreshCurrentWeather());
    });
  }

  Future<Either<CurrentWeatherFailed, CurrentWeatherDoneLoad>>
      _fetchCurrentWeatherBasedOnCoord({required bool isRefresh}) async {
    final currentWeatherResponse =
        await _forecastRepository.getCurrentWeatherByCoordinate(coord: _coord);
    return currentWeatherResponse.fold(
        (exception) => left(CurrentWeatherFailed(exception: exception)),
        (response) => right(isRefresh
            ? CurrentWeatherDoneRefresh(weather: response)
            : CurrentWeatherDoneLoad(weather: response)));
  }
}
