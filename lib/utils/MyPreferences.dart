import 'package:shared_preferences/shared_preferences.dart';

class MyPreferences {
  static Future<bool> saveValue(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();

    if (value is int) {
      return prefs.setInt(key, value);
    } else if (value is double) {
      return prefs.setDouble(key, value);
    } else if (value is bool) {
      return prefs.setBool(key, value);
    } else if (value is String) {
      return prefs.setString(key, value);
    } else if (value is List<String>) {
      return prefs.setStringList(key, value);
    } else {
      throw Exception('Unsupported value type');
    }
  }

  static Future<dynamic> getValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }
}
