import 'package:core/core/commons/error/exceptions.dart';
import 'package:core/core/commons/utils/service/location/i_location_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService implements ILocationService {
  final Location _location;
  LocationService({Location? location}) : _location = location ?? Location();

  @override
  Future<LocationData?> getLocation({bool requirePermission = false}) async {
    try {
      await _handlePermission();
      final location = await _location.getLocation();
      if (location.latitude == null || location.longitude == null) {
        throw LocationException();
      }
      return location;
    } on LocationPermissionDeniedException {
      if (requirePermission) {
        Fluttertoast.showToast(
            msg: 'Please enable location of this app in your phone settings');
        rethrow;
      } else {
        return null;
      }
    } on LocationException {
      if (requirePermission) {
        rethrow;
      } else {
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to retrieve your location!');
      throw LocationException();
    }
  }

  Future<void> _handlePermission() async {
    const locationPermissionStatus = Permission.location;

    try {
      if (await locationPermissionStatus.isGranted) {
        return;
      } else if (await locationPermissionStatus.isPermanentlyDenied) {
        throw LocationPermissionDeniedException();
      } else if (await locationPermissionStatus.isDenied ||
          await locationPermissionStatus.isRestricted ||
          await locationPermissionStatus.isLimited) {
        final status = await locationPermissionStatus.request();
        if (status.isGranted) {
          return;
        }
        throw LocationPermissionDeniedException();
      }
    } catch (e) {
      throw LocationException();
    }
  }
}
