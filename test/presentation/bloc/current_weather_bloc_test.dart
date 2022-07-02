import 'package:bloc_test/bloc_test.dart';
import 'package:core/core/model/model.dart';
import 'package:mockito/mockito.dart';
import 'package:weatherapp/presentation/bloc/current_weather_bloc/current_weather_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import '../../../modules/core/test/presentation/shared_mocks.mocks.dart';

void main() {
  late CurrentWeatherBloc currentWeatherBloc;
  final MockIForecastRepository iForecastRepository = MockIForecastRepository();
  final Coord mockCoord = Coord(lat: 20, lon: 40.5);
  final Coord mockCoordToBeSwitch = Coord(lat: 10, lon: 20);
  final MockCurrentWeather mockCurrentWeather = MockCurrentWeather();
  final MockException mockException = MockException();

  group('test CurrentWeatherBloc', () {
    setUp(() {
      currentWeatherBloc = CurrentWeatherBloc(mockCoord,iForecastRepository);
    });

    blocTest<CurrentWeatherBloc, CurrentWeatherState>(
      """
    testing CurrentWeatherBloc emit CurrentWeatherDoneLoad,
    when add OnLoadCurrentWeather event,
    getCurrentWeatherByCoordinate() is success
    """,
      build: () {
        when(iForecastRepository.getCurrentWeatherByCoordinate(
                coord: mockCoord))
            .thenAnswer((_) => Future.value(right(mockCurrentWeather)));
        return currentWeatherBloc;
      },
      act: (_) => _.add(
        OnLoadCurrentWeather(),
      ),
      expect: () => [
        CurrentWeatherLoading(),
        CurrentWeatherDoneLoad(weather: mockCurrentWeather)
      ],
    );

    blocTest<CurrentWeatherBloc, CurrentWeatherState>(
      """
    testing CurrentWeatherBloc emit CurrentWeatherDoneRefresh,
    when add OnRefreshCurrentWeather event,
    getCurrentWeatherByCoordinate() is success
    """,
      build: () {
        when(iForecastRepository.getCurrentWeatherByCoordinate(
                coord: mockCoord))
            .thenAnswer((_) => Future.value(right(mockCurrentWeather)));
        return currentWeatherBloc;
      },
      act: (_) => _.add(
        OnRefreshCurrentWeather(),
      ),
      expect: () => [
        CurrentWeatherLoading(),
        CurrentWeatherDoneRefresh(weather: mockCurrentWeather)
      ],
    );

    blocTest<CurrentWeatherBloc, CurrentWeatherState>(
      """
    testing CurrentWeatherBloc emit CurrentWeatherFailed,
    when add OnLoadCurrentWeather event,
    getCurrentWeatherByCoordinate() is failed
    """,
      build: () {
        when(iForecastRepository.getCurrentWeatherByCoordinate(
                coord: mockCoord))
            .thenAnswer((_) => Future.value(left(mockException)));
        return currentWeatherBloc;
      },
      act: (_) => _.add(
        OnRefreshCurrentWeather(),
      ),
      expect: () => [
        CurrentWeatherLoading(),
        CurrentWeatherFailed(exception: mockException)
      ],
    );

        blocTest<CurrentWeatherBloc, CurrentWeatherState>(
      """
    testing CurrentWeatherBloc emit OnChangeCurrentWeatherLocation,
    when add OnLoadCurrentWeather event,
    getCurrentWeatherByCoordinate() is Success
    """,
      build: () {
        when(iForecastRepository.getCurrentWeatherByCoordinate(
                coord: mockCoordToBeSwitch))
     .thenAnswer((_) => Future.value(right(mockCurrentWeather)));
        return currentWeatherBloc;
      },
      act: (_) => _.add(
       OnChangeCurrentWeatherLocation(coord: mockCoordToBeSwitch)
      ),
       expect: () => [
        CurrentWeatherLoading(),
        CurrentWeatherDoneRefresh(weather: mockCurrentWeather)
      ],
    );
  });
}
