import 'package:axle_tracking_cms/core/network/api_client.dart';
import 'package:axle_tracking_cms/core/network/app_exception.dart';
import 'package:axle_tracking_cms/core/utils/date_time_utils.dart';
import 'package:axle_tracking_cms/features/alarms/domain/entities/alarm.dart';
import 'package:axle_tracking_cms/features/tracking/domain/entities/live_stream_info.dart';
import 'package:axle_tracking_cms/features/tracking/domain/entities/map_feed_vehicle.dart';
import 'package:axle_tracking_cms/features/tracking/domain/entities/track_history.dart';
import 'package:axle_tracking_cms/features/vehicles/data/models/vehicle_status_response_dto.dart';
import 'package:axle_tracking_cms/features/vehicles/data/models/vehicles_response_dto.dart';
import 'package:axle_tracking_cms/features/vehicles/domain/entities/vehicle.dart';
import 'package:axle_tracking_cms/features/vehicles/domain/entities/vehicle_status.dart';
import 'package:dio/dio.dart';

abstract class GatewayRemoteDataSource {
  Future<List<MapFeedVehicle>> fetchMapFeed();
  Future<LiveStreamInfo> fetchLiveStream(
    String vehicleId, {
    int channel = 0,
    int stream = 1,
  });
  Future<List<Vehicle>> fetchVehicles();
  Future<VehicleStatus> fetchVehicleStatus(String vehicleId);
  Future<TrackHistory> fetchTrackHistory({
    required String vehicleId,
    required DateTime from,
    required DateTime to,
  });
  Future<List<Alarm>> fetchAlarms(
      {required DateTime from, required DateTime to});
}

class GatewayRemoteDataSourceImpl implements GatewayRemoteDataSource {
  GatewayRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;
  static const _slowConnectTimeout = Duration(seconds: 45);
  static const _slowReceiveTimeout = Duration(seconds: 60);

  @override
  Future<List<MapFeedVehicle>> fetchMapFeed() async {
    final response = await _getMapFeedResponse();
    final raw = response.data?['vehicles'];
    if (raw is List) {
      return raw
          .whereType<Map<String, dynamic>>()
          .map(MapFeedVehicle.fromJson)
          .toList(growable: false);
    }
    return const [];
  }

  @override
  Future<LiveStreamInfo> fetchLiveStream(
    String vehicleId, {
    int channel = 0,
    int stream = 1,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/api/v1/vehicles/$vehicleId/live_stream',
      queryParameters: {
        'channel': channel,
        'stream': stream,
      },
    );
    return LiveStreamInfo.fromJson(
      response.data ?? const <String, dynamic>{},
      channel: channel,
      stream: stream,
    );
  }

  Future<Response<Map<String, dynamic>>> _getMapFeedResponse() async {
    try {
      return await _apiClient.get<Map<String, dynamic>>(
        '/api/v1/map_feed',
        connectTimeout: _slowConnectTimeout,
        receiveTimeout: _slowReceiveTimeout,
      );
    } on AppException catch (error) {
      final code = error.code.toLowerCase();
      final isRouteIssue = error.statusCode == 404 ||
          code == 'not_found' ||
          code == 'route_not_found';
      if (!isRouteIssue) rethrow;
    }
    return _apiClient.get<Map<String, dynamic>>(
      '/api/v1/maps/feed',
      connectTimeout: _slowConnectTimeout,
      receiveTimeout: _slowReceiveTimeout,
    );
  }

  @override
  Future<List<Vehicle>> fetchVehicles() async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/api/v1/vehicles',
      connectTimeout: _slowConnectTimeout,
      receiveTimeout: _slowReceiveTimeout,
    );
    return VehiclesResponseDto.fromJson(response.data!).vehicles;
  }

  @override
  Future<VehicleStatus> fetchVehicleStatus(String vehicleId) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/api/v1/vehicles/$vehicleId/status',
      connectTimeout: _slowConnectTimeout,
      receiveTimeout: _slowReceiveTimeout,
    );
    return VehicleStatusResponseDto.fromJson(response.data!).vehicleStatus;
  }

  @override
  Future<TrackHistory> fetchTrackHistory({
    required String vehicleId,
    required DateTime from,
    required DateTime to,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/api/v1/vehicles/$vehicleId/track',
      queryParameters: {
        'from': DateTimeUtils.toBackendDateTime(from),
        'to': DateTimeUtils.toBackendDateTime(to),
      },
    );
    return TrackHistory.fromJson(response.data!);
  }

  @override
  Future<List<Alarm>> fetchAlarms({
    required DateTime from,
    required DateTime to,
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      '/api/v1/alarms',
      queryParameters: {
        'from': DateTimeUtils.toBackendDateTime(from),
        'to': DateTimeUtils.toBackendDateTime(to),
      },
    );

    final raw = response.data?['alarms'];
    if (raw is List) {
      return raw
          .whereType<Map<String, dynamic>>()
          .map(Alarm.fromJson)
          .toList(growable: false);
    }
    return const [];
  }
}
