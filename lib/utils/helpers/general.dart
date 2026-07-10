import 'package:shared_preferences/shared_preferences.dart';

class General {
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

  static Future<void> savePrefStringList(
      String key,
      List<String> value,
      ) async {
    final SharedPreferences preferences =
    await SharedPreferences.getInstance();

    await preferences.setStringList(key, value);
  }

  static Future<List<String>> getPrefStringList(
      String key,
      ) async {
    final SharedPreferences preferences =
    await SharedPreferences.getInstance();

    return preferences.getStringList(key) ?? <String>[];
  }
}