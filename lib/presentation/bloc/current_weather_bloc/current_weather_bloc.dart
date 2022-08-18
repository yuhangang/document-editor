import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:core/core/model/city.dart';
import 'package:core/core/model/model.dart';
import 'package:core/core/repository/i_city_repository.dart';
import 'package:core/core/repository/i_forecast_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:weatherapp/presentation/bloc/city_bloc/city_bloc.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  Either<Coord, MalaysianCity> _location;

  final IForecastRepository _forecastRepository;
  final ICityRepository _cityRepository;
  final CityBloc _cityBloc;

  CurrentWeatherBloc(this._location, this._forecastRepository,
      this._cityRepository, this._cityBloc)
      : super(const CurrentWeatherInitial(null)) {
    on<OnLoadCurrentWeather>((event, emit) async {
      if ((state is CurrentWeatherInitial)) {
        emit(CurrentWeatherLoading(_location));
        await _cityBloc.stream.firstWhere((state) => state is CityDoneLoad);
        await _initCityConfig();
      } else {
        emit(CurrentWeatherLoading(_location));
      }
      final newState =
          await _fetchCurrentWeatherBasedOnCoord(isRefresh: event.isRefresh);
      emit(newState.fold((l) => l, (r) => r));
    }, transformer: droppable());

    on<OnChangeCurrentWeatherCity>((event, emit) async {
      if (_location.isRight() && _location.coord == event.city.coord) {
        return;
      }
      _location = right(event.city);
      await _cityRepository.setCurrentWeatherCitySetting(event.city);
      add(OnRefreshCurrentWeather());
    }, transformer: droppable());
  }

  Future<void> _initCityConfig() async {
    final data = await _cityRepository.getCurrentWeatherCitySetting();
    if (data != null) {
      _location = right(data);
    } else {
      //add(OnChangeCurrentWeatherToUserCurrentLocation());
    }
  }

  Future<Either<CurrentWeatherFailed, CurrentWeatherDoneLoad>>
      _fetchCurrentWeatherBasedOnCoord({required bool isRefresh}) async {
    final currentWeatherResponse = await _forecastRepository
        .getCurrentWeatherByCoordinate(coord: _location.coord);
    return currentWeatherResponse.fold(
        (exception) =>
            left(CurrentWeatherFailed(_location, exception: exception)),
        (response) => right(isRefresh
            ? CurrentWeatherDoneRefresh(_location, weather: response)
            : CurrentWeatherDoneLoad(_location, weather: response)));
  }
}
