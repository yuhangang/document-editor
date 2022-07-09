import 'package:bloc_test/bloc_test.dart';
import 'package:core/core/model/model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:weatherapp/presentation/bloc/weather_forecast_bloc/weather_forecast_bloc.dart';
import '../../../modules/core/test/mock/shared_mocks.mocks.dart';

void main() {
  late WeatherForecastBloc currentWeatherBloc;
  final MockIForecastRepository iForecastRepository = MockIForecastRepository();
  const Coord mockCoord = Coord(lat: 20, lon: 40.5);
  const Coord mockCoordToBeSwitch = Coord(lat: 10, lon: 20);
  final MockWeatherForecastFiveDay mockWeatherForecast = MockWeatherForecastFiveDay();
  final MockException mockException = MockException();

  group('test WeatherForecastBloc', () {
    setUp(() {
      currentWeatherBloc = WeatherForecastBloc(mockCoord,iForecastRepository);
    });

    blocTest<WeatherForecastBloc, WeatherForecastState>(
      """
    testing WeatherForecastBloc emit WeatherForecastDoneLoad,
    when add OnLoadWeatherForecast event,
    getFiveDayWeatherForecastByCoordinate() is success
    """,
      build: () {
        when(iForecastRepository.getFiveDayWeatherForecastByCoordinate(
                coord: mockCoord))
            .thenAnswer((_) => Future.value(right(mockWeatherForecast)));
        return currentWeatherBloc;
      },
      act: (_) => _.add(
        OnLoadWeatherForecast(),
      ),
      expect: () => [
        WeatherForecastLoading(),
        WeatherForecastDoneLoad(forecast: mockWeatherForecast)
      ],
    );

    blocTest<WeatherForecastBloc, WeatherForecastState>(
      """
    testing WeatherForecastBloc emit WeatherForecastDoneRefresh,
    when add OnRefreshWeatherForecast event,
    getFiveDayWeatherForecastByCoordinate() is success
    """,
      build: () {
        when(iForecastRepository.getFiveDayWeatherForecastByCoordinate(
                coord: mockCoord))
            .thenAnswer((_) => Future.value(right(mockWeatherForecast)));
        return currentWeatherBloc;
      },
      act: (_) => _.add(
        OnRefreshWeatherForecast(),
      ),
      expect: () => [
        WeatherForecastLoading(),
        WeatherForecastDoneRefresh(forecast: mockWeatherForecast)
      ],
    );

    blocTest<WeatherForecastBloc, WeatherForecastState>(
      """
    testing WeatherForecastBloc emit WeatherForecastFailed,
    when add OnLoadWeatherForecast event,
    getFiveDayWeatherForecastByCoordinate() is failed
    """,
      build: () {
        when(iForecastRepository.getFiveDayWeatherForecastByCoordinate(
                coord: mockCoord))
            .thenAnswer((_) => Future.value(left(mockException)));
        return currentWeatherBloc;
      },
      act: (_) => _.add(
        OnRefreshWeatherForecast(),
      ),
      expect: () => [
        WeatherForecastLoading(),
        WeatherForecastFailed(exception: mockException)
      ],
    );

    blocTest<WeatherForecastBloc, WeatherForecastState>(
      """
    testing CurrentWeatherBloc emit OnChangeCurrentWeatherLocation,
    when add OnLoadCurrentWeather event,
    getCurrentWeatherByCoordinate() is Success
    """,
      build: () {
        when(iForecastRepository.getFiveDayWeatherForecastByCoordinate(
                coord: mockCoordToBeSwitch))
     .thenAnswer((_) => Future.value(right(mockWeatherForecast)));
        return currentWeatherBloc;
      },
      act: (_) => _.add(
       const OnChangeWeatherForecastLocation(coord: mockCoordToBeSwitch)
      ),
      expect: () => [
        WeatherForecastLoading(),
        WeatherForecastDoneRefresh(forecast: mockWeatherForecast)
      ],
    );
  });
}