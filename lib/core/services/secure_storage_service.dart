import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class SecureStorageService {
  SecureStorageService(this._storage);

  static const _tokenKey = 'jwt_token';
  static String? _fallbackToken;

  final FlutterSecureStorage _storage;

  Future<void> saveToken(String token) async {
    try {
      await _storage.write(key: _tokenKey, value: token);
      _fallbackToken = token;
    } on PlatformException catch (error) {
      if (kDebugMode) {
        debugPrint(
            '[SECURE_STORAGE] write failed (${error.code}), using fallback memory token.');
      }
      _fallbackToken = token;
    }
  }

  Future<String?> readToken() async {
    try {
      return await _storage.read(key: _tokenKey) ?? _fallbackToken;
    } on PlatformException catch (error) {
      if (kDebugMode) {
        debugPrint(
            '[SECURE_STORAGE] read failed (${error.code}), using fallback memory token.');
      }
      return _fallbackToken;
    }
  }

  Future<void> deleteToken() async {
    try {
      await _storage.delete(key: _tokenKey);
    } on PlatformException catch (error) {
      if (kDebugMode) {
        debugPrint(
            '[SECURE_STORAGE] delete failed (${error.code}), clearing fallback memory token.');
      }
    } finally {
      _fallbackToken = null;
    }
  }
}
