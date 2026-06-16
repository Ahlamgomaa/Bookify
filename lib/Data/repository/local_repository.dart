import '../Local/database_helper.dart';
import '../Local/shared_prefs_helper.dart';
import '../Local/secure_storage_helper.dart';

class LocalRepository {

  Future<void> setLoggedIn(bool value, {int? userId}) async {
    await SharedPrefsHelper.setLoggedIn(value, userId: userId);
  }

  Future<bool> isLoggedIn() async {
    return await SharedPrefsHelper.isLoggedIn();
  }

  Future<int?> getUserId() async {
    return await SharedPrefsHelper.getUserId();
  }

  Future<void> logout() async {
    await SharedPrefsHelper.logout();
  }


  Future<void> savePassword(String email, String password) async {
    await SecureStorageHelper.savePassword(email, password);
  }

  Future<String?> getPassword(String email) async {
    return await SecureStorageHelper.getPassword(email);
  }


  Future<int> insertUser(Map<String, dynamic> user) async {
    return await DatabaseHelper.instance.insertUser(user);
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    return await DatabaseHelper.instance.getUserByEmail(email);
  }

  Future<Map<String, dynamic>?> getUserById(int id) async {
    return await DatabaseHelper.instance.getUserById(id);
  }

  Future<int> updateUser(Map<String, dynamic> user) async {
    return await DatabaseHelper.instance.updateUser(user);
  }

  Future<List<Map<String, dynamic>>> getRememberedUsers() async {
    return await DatabaseHelper.instance.getRememberedUsers();
  }


  Future<int> insertFavorite(int userId, String eventId) async {
    return await DatabaseHelper.instance.insertFavorite(userId, eventId);
  }

  Future<int> removeFavorite(int userId, String eventId) async {
    return await DatabaseHelper.instance.removeFavorite(userId, eventId);
  }

  Future<bool> isFavorite(int userId, String eventId) async {
    return await DatabaseHelper.instance.isFavorite(userId, eventId);
  }

  Future<List<Map<String, dynamic>>> getUserFavorites(int userId) async {
    return await DatabaseHelper.instance.getUserFavorites(userId);
  }
}
