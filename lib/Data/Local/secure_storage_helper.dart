import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static const _storage = FlutterSecureStorage();

  static Future<void> savePassword(String email, String password) async {
    await _storage.write(key: 'password_$email', value: password);
  }

  static Future<String?> getPassword(String email) async {
    return await _storage.read(key: 'password_$email');
  }

  static Future<void> deletePassword(String email) async {
    await _storage.delete(key: 'password_$email');
  }
}
