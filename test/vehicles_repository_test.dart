import 'package:axle_tracking_cms/features/gateway/domain/repositories/gateway_repository.dart';
import 'package:axle_tracking_cms/features/vehicles/data/repositories/vehicles_repository_impl.dart';
import 'package:axle_tracking_cms/features/vehicles/domain/entities/vehicle.dart';
import 'package:axle_tracking_cms/features/vehicles/domain/entities/vehicle_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGatewayRepository extends Mock implements GatewayRepository {}

void main() {
  late _MockGatewayRepository gateway;
  late VehiclesRepositoryImpl repository;

  setUp(() {
    gateway = _MockGatewayRepository();
    repository = VehiclesRepositoryImpl(gatewayRepository: gateway);
  });

  test('fetchVehicles returns vehicle list', () async {
    when(() => gateway.fetchVehicles()).thenAnswer(
      (_) async => const [
        Vehicle(id: 'v1', name: 'Truck 1', plateNumber: 'ABC123', online: true),
      ],
    );

    final vehicles = await repository.fetchVehicles();

    expect(vehicles.length, 1);
    expect(vehicles.first.name, 'Truck 1');
  });

  test('fetchVehicleStatus returns status model', () async {
    when(() => gateway.fetchVehicleStatus('v1')).thenAnswer(
      (_) async => VehicleStatus(
        vehicleId: 'v1',
        latitude: 10,
        longitude: 20,
        speedKmh: 50,
        online: true,
        updatedAt: DateTime.parse('2026-02-22T12:00:00Z'),
      ),
    );

    final status = await repository.fetchVehicleStatus('v1');

    expect(status.vehicleId, 'v1');
    expect(status.speedKmh, 50);
  });
}
