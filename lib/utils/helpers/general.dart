import 'package:shared_preferences/shared_preferences.dart';

class General {
  static Future<void> savePrefBool(String key, bool value) async {
    final SharedPreferences preferences =
    await SharedPreferences.getInstance();
    await preferences.setBool(key, value);
  }

  static Future<bool> getPrefBool(
      String key, {
        bool defaultValue = false,
      }) async {
    final SharedPreferences preferences =
    await SharedPreferences.getInstance();
    return preferences.getBool(key) ?? defaultValue;
  }

  static Future<void> savePrefString(
      String key,
      String value,
      ) async {
    final SharedPreferences preferences =
    await SharedPreferences.getInstance();
    await preferences.setString(key, value);
  }

  static Future<String> getPrefString(
      String key, {
        String defaultValue = '',
      }) async {
    final SharedPreferences preferences =
    await SharedPreferences.getInstance();
    return preferences.getString(key) ?? defaultValue;
  }
}