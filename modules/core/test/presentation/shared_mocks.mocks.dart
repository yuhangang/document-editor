// Mocks generated by Mockito 5.0.17 from annotations
// in core/test/presentation/shared_mocks.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:core/core/model/model.dart' as _i3;
import 'package:core/core/repository/i_forecast_repository.dart' as _i4;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeCity_1 extends _i1.Fake implements _i3.City {}

class _FakeCoord_2 extends _i1.Fake implements _i3.Coord {}

class _FakeCurrentWeatherMainData_3 extends _i1.Fake
    implements _i3.CurrentWeatherMainData {}

class _FakeWind_4 extends _i1.Fake implements _i3.Wind {}

class _FakeClouds_5 extends _i1.Fake implements _i3.Clouds {}

class _FakeSys_6 extends _i1.Fake implements _i3.Sys {}

/// A class which mocks [IForecastRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockIForecastRepository extends _i1.Mock
    implements _i4.IForecastRepository {
  MockIForecastRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Either<Exception, _i3.CurrentWeather>>
      getCurrentWeatherByCoordinate({_i3.Coord? coord}) => (super.noSuchMethod(
          Invocation.method(
              #getCurrentWeatherByCoordinate, [], {#coord: coord}),
          returnValue: Future<_i2.Either<Exception, _i3.CurrentWeather>>.value(
              _FakeEither_0<Exception, _i3.CurrentWeather>())) as _i5
          .Future<_i2.Either<Exception, _i3.CurrentWeather>>);
  @override
  _i5.Future<_i2.Either<Exception, _i3.WeatherForecastFiveDay>>
      getFiveDayWeatherForecastByCoordinate({_i3.Coord? coord}) =>
          (super.noSuchMethod(
              Invocation.method(
                  #getFiveDayWeatherForecastByCoordinate, [], {#coord: coord}),
              returnValue:
                  Future<_i2.Either<Exception, _i3.WeatherForecastFiveDay>>.value(
                      _FakeEither_0<Exception, _i3.WeatherForecastFiveDay>())) as _i5
              .Future<_i2.Either<Exception, _i3.WeatherForecastFiveDay>>);
}

/// A class which mocks [WeatherForecastFiveDay].
///
/// See the documentation for Mockito's code generation for more information.
class MockWeatherForecastFiveDay extends _i1.Mock
    implements _i3.WeatherForecastFiveDay {
  MockWeatherForecastFiveDay() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get cod =>
      (super.noSuchMethod(Invocation.getter(#cod), returnValue: '') as String);
  @override
  int get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: 0) as int);
  @override
  int get cnt =>
      (super.noSuchMethod(Invocation.getter(#cnt), returnValue: 0) as int);
  @override
  List<_i3.WeatherForecast> get list =>
      (super.noSuchMethod(Invocation.getter(#list),
          returnValue: <_i3.WeatherForecast>[]) as List<_i3.WeatherForecast>);
  @override
  _i3.City get city =>
      (super.noSuchMethod(Invocation.getter(#city), returnValue: _FakeCity_1())
          as _i3.City);
  @override
  Map<String, dynamic> toJson() =>
      (super.noSuchMethod(Invocation.method(#toJson, []),
          returnValue: <String, dynamic>{}) as Map<String, dynamic>);
}

/// A class which mocks [CurrentWeather].
///
/// See the documentation for Mockito's code generation for more information.
class MockCurrentWeather extends _i1.Mock implements _i3.CurrentWeather {
  MockCurrentWeather() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Coord get coord => (super.noSuchMethod(Invocation.getter(#coord),
      returnValue: _FakeCoord_2()) as _i3.Coord);
  @override
  List<_i3.Weather> get weather =>
      (super.noSuchMethod(Invocation.getter(#weather),
          returnValue: <_i3.Weather>[]) as List<_i3.Weather>);
  @override
  String get base =>
      (super.noSuchMethod(Invocation.getter(#base), returnValue: '') as String);
  @override
  _i3.CurrentWeatherMainData get main =>
      (super.noSuchMethod(Invocation.getter(#main),
              returnValue: _FakeCurrentWeatherMainData_3())
          as _i3.CurrentWeatherMainData);
  @override
  int get visibility =>
      (super.noSuchMethod(Invocation.getter(#visibility), returnValue: 0)
          as int);
  @override
  _i3.Wind get wind =>
      (super.noSuchMethod(Invocation.getter(#wind), returnValue: _FakeWind_4())
          as _i3.Wind);
  @override
  _i3.Clouds get clouds => (super.noSuchMethod(Invocation.getter(#clouds),
      returnValue: _FakeClouds_5()) as _i3.Clouds);
  @override
  int get dt =>
      (super.noSuchMethod(Invocation.getter(#dt), returnValue: 0) as int);
  @override
  _i3.Sys get sys =>
      (super.noSuchMethod(Invocation.getter(#sys), returnValue: _FakeSys_6())
          as _i3.Sys);
  @override
  int get timezone =>
      (super.noSuchMethod(Invocation.getter(#timezone), returnValue: 0) as int);
  @override
  int get id =>
      (super.noSuchMethod(Invocation.getter(#id), returnValue: 0) as int);
  @override
  String get name =>
      (super.noSuchMethod(Invocation.getter(#name), returnValue: '') as String);
  @override
  int get cod =>
      (super.noSuchMethod(Invocation.getter(#cod), returnValue: 0) as int);
  @override
  Map<String, dynamic> toJson() =>
      (super.noSuchMethod(Invocation.method(#toJson, []),
          returnValue: <String, dynamic>{}) as Map<String, dynamic>);
}

/// A class which mocks [Exception].
///
/// See the documentation for Mockito's code generation for more information.
class MockException extends _i1.Mock implements Exception {
  MockException() {
    _i1.throwOnMissingStub(this);
  }
}