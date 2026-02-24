import 'package:axle_tracking_cms/core/services/secure_storage_service.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl(this._storageService);

  final SecureStorageService _storageService;

  @override
  Future<void> clearToken() => _storageService.deleteToken();

  @override
  Future<String?> getToken() => _storageService.readToken();

  @override
  Future<void> saveToken(String token) => _storageService.saveToken(token);
}
