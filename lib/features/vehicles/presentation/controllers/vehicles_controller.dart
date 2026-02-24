import 'package:axle_tracking_cms/core/network/app_exception.dart';
import 'package:axle_tracking_cms/features/vehicles/domain/entities/vehicle.dart';
import 'package:axle_tracking_cms/features/vehicles/domain/repositories/vehicles_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicles_controller.freezed.dart';

@freezed
class VehiclesState with _$VehiclesState {
  const factory VehiclesState({
    @Default(false) bool loading,
    @Default([]) List<Vehicle> vehicles,
    String? errorMessage,
  }) = _VehiclesState;
}

class VehiclesController extends StateNotifier<VehiclesState> {
  VehiclesController(this._repository) : super(const VehiclesState()) {
    loadVehicles();
  }

  final VehiclesRepository _repository;

  Future<void> loadVehicles() async {
    state = state.copyWith(loading: true, errorMessage: null);
    try {
      final vehicles = await _repository.fetchVehicles();
      state = state.copyWith(loading: false, vehicles: vehicles);
    } on AppException catch (error) {
      state = state.copyWith(loading: false, errorMessage: error.userMessage);
    }
  }

  Future<void> refresh() => loadVehicles();
}
