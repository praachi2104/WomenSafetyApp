import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreference {
  static SharedPreferences? _preferences;
  static const String key = 'userType';

  // Ensure proper initialization of SharedPreferences
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Save user type to SharedPreferences
  static Future<void> saveUserType(String type) async {
    await _preferences!.setString(key, type);
  }

  // Retrieve user type from SharedPreferences
  static Future<String?> getUserType() async {
    await init(); // Ensure SharedPreferences is initialized
    return _preferences!.getString(key);
  }
}
