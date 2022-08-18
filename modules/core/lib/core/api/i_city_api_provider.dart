import 'package:core/core/model/city.dart';

abstract class ICityApiProvider {
  Future<List<MalaysianCity>> getMalaysianCityList();
}
