import 'package:axle_tracking_cms/features/gateway/presentation/providers/gateway_providers.dart';
import 'package:axle_tracking_cms/features/tracking/data/repositories/tracking_repository_impl.dart';
import 'package:axle_tracking_cms/features/tracking/domain/entities/map_feed_vehicle.dart';
import 'package:axle_tracking_cms/features/tracking/domain/repositories/tracking_repository.dart';
import 'package:axle_tracking_cms/features/tracking/presentation/controllers/track_history_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final trackingRepositoryProvider = Provider<TrackingRepository>((ref) {
  return TrackingRepositoryImpl(
    gatewayRepository: ref.watch(gatewayRepositoryProvider),
  );
});

final trackHistoryControllerProvider = StateNotifierProvider.family<
    TrackHistoryController, TrackHistoryState, String>((ref, vehicleId) {
  return TrackHistoryController(
    vehicleId: vehicleId,
    repository: ref.watch(trackingRepositoryProvider),
  );
});

final mapFeedProvider = FutureProvider.autoDispose<List<MapFeedVehicle>>((ref) {
  return ref.watch(gatewayRepositoryProvider).fetchMapFeed();
});

final selectedVehicleIdProvider = StateProvider<String?>((_) => null);
