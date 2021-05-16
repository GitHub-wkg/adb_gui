import 'package:shared_preferences/shared_preferences.dart';

class SpUtils {
  static String SCRCPY_PATH = "scrcpy_path" ;


  static put(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
