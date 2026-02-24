import 'package:axle_tracking_cms/features/cms_session/data/datasources/cms_session_remote_data_source.dart';
import 'package:axle_tracking_cms/features/cms_session/data/repositories/cms_session_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockCmsSessionRemoteDataSource extends Mock
    implements CmsSessionRemoteDataSource {}

void main() {
  late _MockCmsSessionRemoteDataSource remote;
  late CmsSessionRepositoryImpl repository;

  setUp(() {
    remote = _MockCmsSessionRemoteDataSource();
    repository = CmsSessionRepositoryImpl(remote);
  });

  test('login delegates to remote datasource', () async {
    when(() => remote.login()).thenAnswer((_) async {});

    await repository.login();

    verify(() => remote.login()).called(1);
  });

  test('loginDiagnostic delegates to remote datasource', () async {
    when(() => remote.loginDiagnostic()).thenAnswer(
      (_) async => {'status': 'ok'},
    );

    final result = await repository.loginDiagnostic();

    expect(result['status'], 'ok');
    verify(() => remote.loginDiagnostic()).called(1);
  });
}
