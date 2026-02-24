import 'package:axle_tracking_cms/features/tracking/domain/entities/track_history.dart';

abstract class TrackingRepository {
  Future<TrackHistory> fetchTrackHistory({
    required String vehicleId,
    required DateTime from,
    required DateTime to,
  });
}
