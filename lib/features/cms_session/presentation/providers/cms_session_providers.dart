import 'package:axle_tracking_cms/core/config/app_providers.dart';
import 'package:axle_tracking_cms/features/cms_session/data/datasources/cms_session_remote_data_source.dart';
import 'package:axle_tracking_cms/features/cms_session/data/repositories/cms_session_repository_impl.dart';
import 'package:axle_tracking_cms/features/cms_session/domain/repositories/cms_session_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cmsSessionRemoteDataSourceProvider =
    Provider<CmsSessionRemoteDataSource>((ref) {
  return CmsSessionRemoteDataSourceImpl(ref.watch(apiClientProvider));
});

final cmsSessionRepositoryProvider = Provider<CmsSessionRepository>((ref) {
  return CmsSessionRepositoryImpl(
      ref.watch(cmsSessionRemoteDataSourceProvider));
});
