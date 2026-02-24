import 'package:axle_tracking_cms/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:axle_tracking_cms/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:axle_tracking_cms/features/auth/data/models/auth_response_dto.dart';
import 'package:axle_tracking_cms/features/auth/domain/entities/auth_session.dart';
import 'package:axle_tracking_cms/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  @override
  Future<String?> getSavedToken() => _localDataSource.getToken();

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    final response =
        await _remoteDataSource.login(email: email, password: password);
    await _localDataSource.saveToken(response.token);
    await _remoteDataSource.initializeCmsSession();
    return response.toDomain();
  }

  @override
  Future<AuthSession> register({
    required String email,
    required String password,
  }) async {
    final response =
        await _remoteDataSource.register(email: email, password: password);
    await _localDataSource.saveToken(response.token);
    await _remoteDataSource.initializeCmsSession();
    return response.toDomain();
  }

  @override
  Future<void> initializeCmsSession() =>
      _remoteDataSource.initializeCmsSession();

  @override
  Future<void> logout() => _localDataSource.clearToken();
}
