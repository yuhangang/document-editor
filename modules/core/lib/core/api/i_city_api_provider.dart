import 'package:core/core/model/city.dart';

import '../model/country/continent.dart';

abstract class ICityApiProvider {
  Future<List<MalaysianCity>> getMalaysianCityList();

  Future<List<Continent>> getLocationData();
}
