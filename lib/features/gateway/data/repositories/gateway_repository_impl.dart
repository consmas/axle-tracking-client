import 'package:axle_tracking_cms/core/network/app_exception.dart';
import 'package:axle_tracking_cms/features/alarms/domain/entities/alarm.dart';
import 'package:axle_tracking_cms/features/gateway/data/datasources/gateway_remote_data_source.dart';
import 'package:axle_tracking_cms/features/gateway/domain/repositories/gateway_repository.dart';
import 'package:axle_tracking_cms/features/tracking/domain/entities/live_stream_info.dart';
import 'package:axle_tracking_cms/features/tracking/domain/entities/map_feed_vehicle.dart';
import 'package:axle_tracking_cms/features/tracking/domain/entities/track_history.dart';
import 'package:axle_tracking_cms/features/vehicles/domain/entities/vehicle.dart';
import 'package:axle_tracking_cms/features/vehicles/domain/entities/vehicle_status.dart';

class GatewayRepositoryImpl implements GatewayRepository {
  GatewayRepositoryImpl({required GatewayRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  final GatewayRemoteDataSource _remoteDataSource;

  @override
  Future<LiveStreamInfo> fetchLiveStream(
    String vehicleId, {
    int channel = 0,
    int stream = 1,
  }) {
    return _remoteDataSource.fetchLiveStream(
      vehicleId,
      channel: channel,
      stream: stream,
    );
  }

  @override
  Future<List<MapFeedVehicle>> fetchMapFeed() async {
    try {
      return await _remoteDataSource.fetchMapFeed();
    } on AppException {
      final vehicles = await _remoteDataSource.fetchVehicles();
      final statuses = await Future.wait(
        vehicles
            .map((vehicle) => _remoteDataSource.fetchVehicleStatus(vehicle.id)),
      );

      return List<MapFeedVehicle>.generate(vehicles.length, (index) {
        final vehicle = vehicles[index];
        final status = statuses[index];
        return MapFeedVehicle(
          id: vehicle.id,
          name: vehicle.name,
          plateNumber: vehicle.plateNumber,
          online: vehicle.online,
          status: MapFeedStatus(
            latitude: status.latitude,
            longitude: status.longitude,
            speedKmh: status.speedKmh,
            updatedAt: status.updatedAt,
          ),
          liveStream: null,
        );
      });
    }
  }

  @override
  Future<List<Vehicle>> fetchVehicles() => _remoteDataSource.fetchVehicles();

  @override
  Future<VehicleStatus> fetchVehicleStatus(String vehicleId) =>
      _remoteDataSource.fetchVehicleStatus(vehicleId);

  @override
  Future<TrackHistory> fetchTrackHistory({
    required String vehicleId,
    required DateTime from,
    required DateTime to,
  }) {
    return _remoteDataSource.fetchTrackHistory(
      vehicleId: vehicleId,
      from: from,
      to: to,
    );
  }

  @override
  Future<List<Alarm>> fetchAlarms({
    required DateTime from,
    required DateTime to,
  }) {
    return _remoteDataSource.fetchAlarms(from: from, to: to);
  }
}
