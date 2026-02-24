import 'package:axle_tracking_cms/features/cms_session/data/datasources/cms_session_remote_data_source.dart';
import 'package:axle_tracking_cms/features/cms_session/domain/repositories/cms_session_repository.dart';

class CmsSessionRepositoryImpl implements CmsSessionRepository {
  CmsSessionRepositoryImpl(this._remoteDataSource);

  final CmsSessionRemoteDataSource _remoteDataSource;

  @override
  Future<void> login() => _remoteDataSource.login();

  @override
  Future<Map<String, dynamic>> loginDiagnostic() =>
      _remoteDataSource.loginDiagnostic();
}
