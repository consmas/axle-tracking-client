import 'package:axle_tracking_cms/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:axle_tracking_cms/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:axle_tracking_cms/features/auth/data/models/auth_response_dto.dart';
import 'package:axle_tracking_cms/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:axle_tracking_cms/features/auth/domain/entities/auth_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class _MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  late _MockAuthRemoteDataSource remote;
  late _MockAuthLocalDataSource local;
  late AuthRepositoryImpl repository;

  setUp(() {
    remote = _MockAuthRemoteDataSource();
    local = _MockAuthLocalDataSource();
    repository =
        AuthRepositoryImpl(remoteDataSource: remote, localDataSource: local);
  });

  test('login stores token, initializes CMS session, and returns session',
      () async {
    when(
      () => remote.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer(
      (_) async => AuthResponseDto(
        token: 'jwt-token',
        user: const AuthUser(email: 'admin@axle.com', id: '1'),
      ),
    );
    when(() => local.saveToken(any())).thenAnswer((_) async {});
    when(() => remote.initializeCmsSession()).thenAnswer((_) async {});

    final session = await repository.login(
      email: 'admin@axle.com',
      password: 'password',
    );

    expect(session.token, 'jwt-token');
    verify(() => local.saveToken('jwt-token')).called(1);
    verify(() => remote.initializeCmsSession()).called(1);
  });
}
