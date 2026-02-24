import 'package:axle_tracking_cms/core/network/api_client.dart';
import 'package:axle_tracking_cms/core/services/secure_storage_service.dart';
import 'package:axle_tracking_cms/core/services/session_invalidator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final flutterSecureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService(ref.watch(flutterSecureStorageProvider));
});

final sessionInvalidatorProvider = Provider<SessionInvalidator>((ref) {
  return SessionInvalidator();
});

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(
    storageService: ref.watch(secureStorageServiceProvider),
    sessionInvalidator: ref.watch(sessionInvalidatorProvider),
  );
});
