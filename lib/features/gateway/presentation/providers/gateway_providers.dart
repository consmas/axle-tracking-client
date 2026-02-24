import 'package:axle_tracking_cms/core/config/app_providers.dart';
import 'package:axle_tracking_cms/features/gateway/data/datasources/gateway_remote_data_source.dart';
import 'package:axle_tracking_cms/features/gateway/data/repositories/gateway_repository_impl.dart';
import 'package:axle_tracking_cms/features/gateway/domain/repositories/gateway_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gatewayRemoteDataSourceProvider =
    Provider<GatewayRemoteDataSource>((ref) {
  return GatewayRemoteDataSourceImpl(ref.watch(apiClientProvider));
});

final gatewayRepositoryProvider = Provider<GatewayRepository>((ref) {
  return GatewayRepositoryImpl(
    remoteDataSource: ref.watch(gatewayRemoteDataSourceProvider),
  );
});
