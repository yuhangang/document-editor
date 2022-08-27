import 'package:core/core/model/city.dart';
import 'package:core/core/model/country/continent.dart';

abstract class ICityApiProvider {
  Future<List<MalaysianCity>> getMalaysianCityList();
  Future<List<Continent>> getContinentList();
}
