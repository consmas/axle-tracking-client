import 'package:axle_tracking_cms/core/network/api_client.dart';

abstract class CmsSessionRemoteDataSource {
  Future<void> login();
  Future<Map<String, dynamic>> loginDiagnostic();
}

class CmsSessionRemoteDataSourceImpl implements CmsSessionRemoteDataSource {
  CmsSessionRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<void> login() => _apiClient.initializeCmsSession();

  @override
  Future<Map<String, dynamic>> loginDiagnostic() =>
      _apiClient.cmsLoginDiagnostic();
}
