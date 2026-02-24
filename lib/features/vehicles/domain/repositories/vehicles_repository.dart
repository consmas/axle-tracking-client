import 'package:axle_tracking_cms/features/vehicles/domain/entities/vehicle.dart';
import 'package:axle_tracking_cms/features/vehicles/domain/entities/vehicle_status.dart';

abstract class VehiclesRepository {
  Future<List<Vehicle>> fetchVehicles();
  Future<VehicleStatus> fetchVehicleStatus(String vehicleId);
}
