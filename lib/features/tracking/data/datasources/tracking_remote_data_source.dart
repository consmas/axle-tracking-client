import 'package:axle_tracking_cms/core/network/api_client.dart';
import 'package:axle_tracking_cms/features/tracking/domain/entities/track_history.dart';

abstract class TrackingRemoteDataSource {
  Future<TrackHistory> fetchTrackHistory({
    required String vehicleId,
    required DateTime from,
    required DateTime to,
  });
}

class TrackingRemoteDataSourceImpl implements TrackingRemoteDataSource {
  TrackingRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<TrackHistory> fetchTrackHistory({
    required String vehicleId,
    required DateTime from,
    required DateTime to,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/api/v1/vehicles/$vehicleId/track',
      queryParameters: {
        'from': from.toIso8601String(),
        'to': to.toIso8601String(),
      },
    );
    return TrackHistory.fromJson(response.data!);
  }
}
