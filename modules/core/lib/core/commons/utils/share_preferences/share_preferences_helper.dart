import 'dart:convert';

// import 'package:core/core/api/user_api_provider.dart';
import 'package:core/core/model/device_info.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin SharePreferencesHelper {
  static const String _refreshTokenKey = "refresh_token";
  static const String _deviceInfoKey = "device_info";
  Future<void> setRefreshToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_refreshTokenKey, value);
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  Future<DeviceInfo?> getSavedDeviceInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_deviceInfoKey);
    if (saved == null) return null;
    return DeviceInfo.fromJson(jsonDecode(saved));
  }

  Future<void> saveDeviceInfoToPref(DeviceInfo deviceInfo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_deviceInfoKey, jsonEncode(deviceInfo.toJson()));
  }
}

// TODO: Implemented a JWT Refresh Handler
/*
class JWTHelper {
  final UserApiProvider userApiProvider;

  JWTHelper({
    required this.userApiProvider,
  });
  static const String _refreshTokenKey = "refresh_token";
  DateTime? scheduledTimeToRefresh;

  Future<bool> checkNeedToRefreshToken(String token) async {
    /* decode() method will decode your token's payload */
    // Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    bool isTokenExpired = JwtDecoder.isExpired(token);
    if (!isTokenExpired) {
      return true;
    }
    /* getExpirationDate() - this method returns the expiration date of the token */
    DateTime expirationDate = JwtDecoder.getExpirationDate(token);
    final currentTime = DateTime.now();
    if (expirationDate.difference(currentTime).inHours < 1) {
      return true;
    } else if (expirationDate.isBefore(currentTime)) {
      return true;
    }
    scheduledTimeToRefresh = expirationDate.subtract(const Duration(hours: 1));
    return false;
  }

  Future<void> setRefreshToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_refreshTokenKey, value);
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final storedToken = prefs.getString(_refreshTokenKey);
    if (storedToken != null &&
        !((scheduledTimeToRefresh?.difference(DateTime.now()).inHours ??
                double.infinity) >
            1)) {
      return storedToken;
    } else {
      userApiProvider.login(deviceId);
    }
  }
}

*/
