import 'package:core/core/commons/utils/service/location/i_location_service.dart';
import 'package:core/core/model/model.dart';
import 'package:core/core/repository/city_repository.dart';
import 'package:core/core/repository/i_city_repository.dart';
import 'package:core/core/repository/i_forecast_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:storage/core/storage/i_local_storage.dart';

@GenerateMocks([
  // Repository
  IForecastRepository,
    ICityRepository,

  //Services
  ILocationService,
  ILocalStorage,

  // Model
  WeatherForecastFiveDay,
  CurrentWeather,

  // Exception
  Exception
  
  ])



void main() {}