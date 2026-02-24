import 'package:axle_tracking_cms/features/alarms/domain/entities/alarm.dart';
import 'package:axle_tracking_cms/features/tracking/domain/entities/live_stream_info.dart';
import 'package:axle_tracking_cms/features/tracking/domain/entities/track_history.dart';
import 'package:axle_tracking_cms/features/tracking/domain/entities/map_feed_vehicle.dart';
import 'package:axle_tracking_cms/features/vehicles/domain/entities/vehicle.dart';
import 'package:axle_tracking_cms/features/vehicles/domain/entities/vehicle_status.dart';

abstract class GatewayRepository {
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
