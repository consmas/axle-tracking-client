import 'dart:async';

import 'package:axle_tracking_cms/core/network/app_exception.dart';
import 'package:axle_tracking_cms/features/vehicles/domain/entities/vehicle_status.dart';
import 'package:axle_tracking_cms/features/vehicles/presentation/providers/vehicles_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'live_tracking_controller.freezed.dart';

@freezed
class LiveTrackingState with _$LiveTrackingState {
  const factory LiveTrackingState({
    @Default(false) bool loading,
    VehicleStatus? status,
    LatLng? markerPosition,
    String? errorMessage,
  }) = _LiveTrackingState;
}

class LiveTrackingController extends StateNotifier<LiveTrackingState> {
  LiveTrackingController({required this.vehicleId, required this.ref})
      : super(const LiveTrackingState()) {
    _load();
    _timer = Timer.periodic(const Duration(seconds: 10), (_) => _load());
  }

  final String vehicleId;
  final Ref ref;
  Timer? _timer;

  Future<void> _load() async {
    state = state.copyWith(loading: true, errorMessage: null);
    try {
      final repository = ref.read(vehiclesRepositoryProvider);
      final next = await repository.fetchVehicleStatus(vehicleId);
      await _animateMarkerTo(LatLng(next.latitude, next.longitude));
      state = state.copyWith(loading: false, status: next);
    } on AppException catch (error) {
      state = state.copyWith(loading: false, errorMessage: error.userMessage);
    }
  }

  Future<void> _animateMarkerTo(LatLng target) async {
    final start = state.markerPosition;
    if (start == null) {
      state = state.copyWith(markerPosition: target);
      return;
    }

    const steps = 10;
    for (var i = 1; i <= steps; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      final t = i / steps;
      final lat = start.latitude + (target.latitude - start.latitude) * t;
      final lng = start.longitude + (target.longitude - start.longitude) * t;
      state = state.copyWith(markerPosition: LatLng(lat, lng));
    }
  }

  Future<void> refresh() => _load();

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final liveTrackingControllerProvider = StateNotifierProvider.family<
    LiveTrackingController, LiveTrackingState, String>((ref, vehicleId) {
  return LiveTrackingController(vehicleId: vehicleId, ref: ref);
});
