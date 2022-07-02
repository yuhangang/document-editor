import 'package:core/core/model/model.dart';
import 'package:core/core/repository/i_forecast_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  // Repository
  IForecastRepository,
  
  // Model
  WeatherForecastFiveDay,
  CurrentWeather,

  // Exception
  Exception
  ])



void main() {}