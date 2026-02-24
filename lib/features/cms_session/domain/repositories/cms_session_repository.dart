abstract class CmsSessionRepository {
  Future<void> login();
  Future<Map<String, dynamic>> loginDiagnostic();
}
