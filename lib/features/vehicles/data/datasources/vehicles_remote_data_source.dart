import 'package:axle_tracking_cms/core/network/api_client.dart';
import 'package:axle_tracking_cms/features/vehicles/data/models/vehicle_status_response_dto.dart';
import 'package:axle_tracking_cms/features/vehicles/data/models/vehicles_response_dto.dart';
import 'package:axle_tracking_cms/features/vehicles/domain/entities/vehicle.dart';
import 'package:axle_tracking_cms/features/vehicles/domain/entities/vehicle_status.dart';

abstract class VehiclesRemoteDataSource {
  Future<List<Vehicle>> fetchVehicles();
  Future<VehicleStatus> fetchVehicleStatus(String vehicleId);
}

class VehiclesRemoteDataSourceImpl implements VehiclesRemoteDataSource {
  VehiclesRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<List<Vehicle>> fetchVehicles() async {
    final response =
        await _apiClient.get<Map<String, dynamic>>('/api/v1/vehicles');
    final dto = VehiclesResponseDto.fromJson(response.data!);
    return dto.vehicles;
  }

  @override
  Future<VehicleStatus> fetchVehicleStatus(String vehicleId) async {
    final response = await _apiClient
        .get<Map<String, dynamic>>('/api/v1/vehicles/$vehicleId/status');
    final dto = VehicleStatusResponseDto.fromJson(response.data!);
    return dto.vehicleStatus;
  }
}
