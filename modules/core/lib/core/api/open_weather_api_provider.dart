import 'dart:developer';

import 'package:core/core/api/i_open_weather_api_provider.dart';
import 'package:core/core/commons/app_env.dart';
import 'package:core/core/commons/error/api_exception_handler.dart';
import 'package:core/core/model/model.dart';
import 'package:core/network/http_response.dart';
import 'package:core/network/i_network_client.dart';
import 'package:dio/dio.dart';

class OpenWeatherApiProvider
    with ApiClientExceptionHandler
    implements IOpenWeatherApiProvider {
  final INetworkClient client;
  final AppEnv appEnv;
  OpenWeatherApiProvider({
    required this.client,
    required this.appEnv,
  });
  @override
  Future<CurrentWeather> getCurrentWeatherByCoordinate(
      {required Coord coord}) async {
    try {
      
      final HttpResponse<Map<String, dynamic>> res =
          await client.get<Map<String, dynamic>>(_getLocationWeatherUrl('weather',coord: coord,units: SystemOfUnit.metric,));

      final response = CurrentWeather.fromJson(res.data!);
      return response;
    } on DioError catch (exception) {
      throw apiExceptionHandler(exception);
    } on Error catch (error) {
      throw apiExceptionHandler(Exception(error.toString()), error: error);
    }
  }

  @override
  Future<WeatherForecastFiveDay> getFiveDayWeatherForecastByCoordinate(
      {required Coord coord}) async {
    try {
      final String path =
          '${appEnv.openWeatherApiBaseUrl}/forecast?lat=${coord.lat}&lon=${coord.lon}&appid=${appEnv.openWeatherApiKey}';
      final HttpResponse<Map<String, dynamic>> res =
          await client.get<Map<String, dynamic>>(path);
      
      final response = WeatherForecastFiveDay.fromJson(res.data!);
     
      return response;
    } on DioError catch (exception) {
       log("yolo ${exception.response} ${exception.error}");
      throw apiExceptionHandler(exception);
    } on Error catch (error) {
      throw apiExceptionHandler(Exception(error.toString()), error: error);
    }
  }

  String _getLocationWeatherUrl(String usage,
      {required Coord coord,
      required SystemOfUnit units,
      String lang = 'eng'}) {
        log("yolo ${appEnv.openWeatherApiBaseUrl}/$usage?lat=${coord.lat}&lon=${coord.lon}&appid=${appEnv.openWeatherApiKey}&units=${units.name}&lang=$lang");
    return "${appEnv.openWeatherApiBaseUrl}/$usage?lat=${coord.lat}&lon=${coord.lon}&appid=${appEnv.openWeatherApiKey}&units=${units.name}&lang=$lang";
  }
}
