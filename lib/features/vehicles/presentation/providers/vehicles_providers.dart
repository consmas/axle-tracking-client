import 'package:axle_tracking_cms/features/gateway/presentation/providers/gateway_providers.dart';
import 'package:axle_tracking_cms/features/vehicles/data/repositories/vehicles_repository_impl.dart';
import 'package:axle_tracking_cms/features/vehicles/domain/entities/vehicle_status.dart';
import 'package:axle_tracking_cms/features/vehicles/domain/repositories/vehicles_repository.dart';
import 'package:axle_tracking_cms/features/vehicles/presentation/controllers/vehicles_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final vehiclesRepositoryProvider = Provider<VehiclesRepository>((ref) {
  return VehiclesRepositoryImpl(
    gatewayRepository: ref.watch(gatewayRepositoryProvider),
  );
});

final vehiclesControllerProvider =
    StateNotifierProvider<VehiclesController, VehiclesState>((ref) {
  return VehiclesController(ref.watch(vehiclesRepositoryProvider));
});

final vehicleStatusProvider =
    FutureProvider.family<VehicleStatus, String>((ref, id) {
  final repository = ref.watch(vehiclesRepositoryProvider);
  return repository.fetchVehicleStatus(id);
});
