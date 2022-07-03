import 'package:core/core/commons/utils/service/location/i_location_service.dart';
import 'package:core/core/model/model.dart';
import 'package:core/core/repository/i_forecast_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  // Repository
  IForecastRepository,

  //Services
  ILocationService,

  // Model
  WeatherForecastFiveDay,
  CurrentWeather,

  // Exception
  Exception
  ])



void main() {}