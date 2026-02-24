import 'package:axle_tracking_cms/features/auth/domain/entities/auth_session.dart';

abstract class AuthRepository {
  Future<AuthSession> login({required String email, required String password});
  Future<AuthSession> register(
      {required String email, required String password});
  Future<void> logout();
  Future<String?> getSavedToken();
  Future<void> initializeCmsSession();
}
