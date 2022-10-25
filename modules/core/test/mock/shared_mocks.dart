import 'package:core/core/commons/utils/service/location/i_location_service.dart';
import 'package:core/core/model/city.dart';
import 'package:core/core/model/model.dart';
import 'package:location/location.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  //Services
  ILocationService,

  // Model
  WeatherForecastFiveDay,
  CurrentWeather,
  MalaysianCity,
  LocationData,

  // Exception
  Exception
])
void main() {}
