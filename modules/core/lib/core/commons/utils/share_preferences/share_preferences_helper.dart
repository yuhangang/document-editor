import 'dart:convert';

import 'package:core/core/model/device_info.dart';
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
