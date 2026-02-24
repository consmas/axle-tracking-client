import 'package:axle_tracking_cms/core/network/api_client.dart';
import 'package:axle_tracking_cms/features/auth/data/models/auth_response_dto.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseDto> login(
      {required String email, required String password});
  Future<AuthResponseDto> register(
      {required String email, required String password});
  Future<void> initializeCmsSession();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<AuthResponseDto> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/api/auth/login',
      data: {
        'user': {'email': email, 'password': password},
      },
    );
    return AuthResponseDto.fromJson(response.data!);
  }

  @override
  Future<AuthResponseDto> register({
    required String email,
    required String password,
  }) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/api/auth/register',
      data: {
        'user': {
          'email': email,
          'password': password,
          'password_confirmation': password,
        },
      },
    );
    return AuthResponseDto.fromJson(response.data!);
  }

  @override
  Future<void> initializeCmsSession() => _apiClient.initializeCmsSession();
}
