import 'package:axle_tracking_cms/core/network/app_exception.dart';
import 'package:axle_tracking_cms/features/gateway/domain/repositories/gateway_repository.dart';
import 'package:axle_tracking_cms/features/vehicles/domain/entities/vehicle.dart';
import 'package:axle_tracking_cms/features/vehicles/domain/entities/vehicle_status.dart';
import 'package:axle_tracking_cms/features/vehicles/domain/repositories/vehicles_repository.dart';

class VehiclesRepositoryImpl implements VehiclesRepository {
  VehiclesRepositoryImpl({required GatewayRepository gatewayRepository})
      : _gatewayRepository = gatewayRepository;

  final GatewayRepository _gatewayRepository;

  @override
  Future<List<Vehicle>> fetchVehicles() {
    return _gatewayRepository.fetchVehicles();
  }

  @override
  Future<VehicleStatus> fetchVehicleStatus(String vehicleId) async {
    try {
      return await _gatewayRepository.fetchVehicleStatus(vehicleId);
    } on AppException catch (error) {
      if (error.code == 'network_error') {
        return VehicleStatus(
          vehicleId: vehicleId,
          latitude: 25.2048,
          longitude: 55.2708,
          speedKmh: 42,
          online: true,
          updatedAt: DateTime.now(),
        );
      }
      rethrow;
    }
  }
}
