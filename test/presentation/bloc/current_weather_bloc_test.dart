import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:core/core/model/city.dart';
import 'package:core/core/model/model.dart';
import 'package:mockito/mockito.dart';
import 'package:weatherapp/presentation/bloc/city_bloc/city_bloc.dart';
import 'package:weatherapp/presentation/bloc/current_weather_bloc/current_weather_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import '../../../modules/core/test/mock/shared_mocks.mocks.dart';
import '../../mock/shared_mocks.mocks.dart';

void main() {
  late CurrentWeatherBloc currentWeatherBloc;
  final MockIForecastRepository iForecastRepository = MockIForecastRepository();
  const mockCoord = Coord(lat: 20, lon: 40.5);
  const Coord mockMalaysianCityCoord = Coord(lat: 120.0, lon: 140.5);
  final Either<Coord, MalaysianCity> mockLocation = left(mockCoord);
  final mockMalaysianCity = MockMalaysianCity();
  final Either<Coord, MalaysianCity> mockLocationToBeSwitch =
      right(mockMalaysianCity);
  final MockCurrentWeather mockCurrentWeather = MockCurrentWeather();
  final MockException mockException = MockException();
  final MockCityBloc mockCityBloc = MockCityBloc();
  final MockICityRepository mockICityRepository = MockICityRepository();
  final StreamController<CityState> cityStateStreamController =
      StreamController<CityState>();

  group('test CurrentWeatherBloc', () {
    setUp(() {
      currentWeatherBloc = CurrentWeatherBloc(
          mockLocation, iForecastRepository, mockICityRepository, mockCityBloc);
      when(mockMalaysianCity.coord).thenReturn(mockMalaysianCityCoord);
      when(mockCityBloc.stream)
          .thenAnswer((_) => cityStateStreamController.stream);
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
        when(mockICityRepository.getCurrentWeatherCitySetting())
            .thenAnswer((realInvocation) => Future.value(mockMalaysianCity));
        when(iForecastRepository.getCurrentWeatherByCoordinate(
                coord: mockMalaysianCity.coord))
            .thenAnswer(
                (realInvocation) => Future.value(right(mockCurrentWeather)));
        when(mockMalaysianCity.coord).thenReturn(mockMalaysianCityCoord);
        return currentWeatherBloc;
      },
      act: (_) async {
        _.add(
          OnLoadCurrentWeather(),
        );
        Future.delayed(Duration.zero, () {
          cityStateStreamController
              .add(const CityDoneLoad(cities: [], selectedCities: []));
        });
      },
      expect: () => [
        isA<CurrentWeatherLoading>(),
        CurrentWeatherDoneLoad(mockLocation, weather: mockCurrentWeather)
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
        isA<CurrentWeatherLoading>(),
        CurrentWeatherDoneRefresh(mockLocation, weather: mockCurrentWeather)
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
        isA<CurrentWeatherLoading>(),
        CurrentWeatherFailed(mockLocation, exception: mockException)
      ],
    );

    blocTest<CurrentWeatherBloc, CurrentWeatherState>(
      """
    testing CurrentWeatherBloc emit OnChangeCurrentWeatherCity,
    when add OnLoadCurrentWeather event,
    getCurrentWeatherByCoordinate() is Success
    """,
      build: () {
        when(iForecastRepository.getCurrentWeatherByCoordinate(
                coord: mockMalaysianCityCoord))
            .thenAnswer((_) => Future.value(right(mockCurrentWeather)));
        return currentWeatherBloc;
      },
      act: (_) => _.add(OnChangeCurrentWeatherCity(city: mockMalaysianCity)),
      expect: () => [
        isA<CurrentWeatherLoading>(),
        CurrentWeatherDoneRefresh(mockLocationToBeSwitch,
            weather: mockCurrentWeather)
      ],
    );
  });
}
