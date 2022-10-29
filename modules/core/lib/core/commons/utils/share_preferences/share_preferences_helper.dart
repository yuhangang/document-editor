import 'package:shared_preferences/shared_preferences.dart';

mixin SharePreferencesHelper {
  static const String _refreshTokenKey = "refresh_token";
  Future<void> setRefreshToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_refreshTokenKey, value);
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }
}
