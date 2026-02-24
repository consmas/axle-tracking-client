import 'package:axle_tracking_cms/core/config/app_providers.dart';
import 'package:axle_tracking_cms/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:axle_tracking_cms/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:axle_tracking_cms/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:axle_tracking_cms/features/auth/domain/repositories/auth_repository.dart';
import 'package:axle_tracking_cms/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(ref.watch(apiClientProvider));
});

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSourceImpl(ref.watch(secureStorageServiceProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    localDataSource: ref.watch(authLocalDataSourceProvider),
  );
});

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(
    ref.watch(authRepositoryProvider),
    ref.watch(sessionInvalidatorProvider),
  );
});
