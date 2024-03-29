import 'package:location/location.dart';

abstract class ILocationService {
  Future<LocationData?> getLocation({bool requirePermission = false});
}
