import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static const String _isLoggedKey = 'isLogged';
  static const String _userIdKey = 'userId';

  static Future<void> setLoggedIn(bool value, {int? userId}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedKey, value);
    if (userId != null) {
      await prefs.setInt(_userIdKey, userId);
    } else {
      await prefs.remove(_userIdKey);
    }
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedKey) ?? false;
  }

  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userIdKey);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isLoggedKey);
    await prefs.remove(_userIdKey);
  }
}
