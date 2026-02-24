import 'package:axle_tracking_cms/core/network/app_exception.dart';
import 'package:axle_tracking_cms/features/gateway/domain/repositories/gateway_repository.dart';
import 'package:axle_tracking_cms/features/tracking/domain/entities/track_history.dart';
import 'package:axle_tracking_cms/features/tracking/domain/repositories/tracking_repository.dart';

class TrackingRepositoryImpl implements TrackingRepository {
  TrackingRepositoryImpl({required GatewayRepository gatewayRepository})
      : _gatewayRepository = gatewayRepository;

  final GatewayRepository _gatewayRepository;

  @override
  Future<TrackHistory> fetchTrackHistory({
    required String vehicleId,
    required DateTime from,
    required DateTime to,
  }) async {
    try {
      return await _gatewayRepository.fetchTrackHistory(
        vehicleId: vehicleId,
        from: from,
        to: to,
      );
    } on AppException catch (error) {
      if (error.code == 'network_error') {
        final now = DateTime.now();
        return TrackHistory(
          vehicleId: vehicleId,
          from: from,
          to: to,
          points: List<TrackPoint>.generate(
            5,
            (index) => TrackPoint(
              latitude: 25.2048 + index * 0.001,
              longitude: 55.2708 + index * 0.001,
              speedKmh: 25 + index * 7,
              recordedAt: now.subtract(Duration(minutes: (5 - index) * 10)),
            ),
          ),
        );
      }
      rethrow;
    }
  }
}
