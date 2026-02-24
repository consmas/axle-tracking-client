import 'package:axle_tracking_cms/core/network/app_exception.dart';
import 'package:axle_tracking_cms/features/alarms/domain/entities/alarm.dart';
import 'package:axle_tracking_cms/features/gateway/domain/repositories/gateway_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'alarms_controller.freezed.dart';

@freezed
class AlarmsState with _$AlarmsState {
  const factory AlarmsState({
    @Default(false) bool loading,
    @Default([]) List<Alarm> alarms,
    DateTime? from,
    DateTime? to,
    String? errorMessage,
  }) = _AlarmsState;
}

class AlarmsController extends StateNotifier<AlarmsState> {
  AlarmsController(this._gatewayRepository)
      : super(
          AlarmsState(
            from: DateTime.now().subtract(const Duration(hours: 24)),
            to: DateTime.now(),
          ),
        ) {
    load();
  }

  final GatewayRepository _gatewayRepository;

  Future<void> load() async {
    final from = state.from;
    final to = state.to;
    if (from == null || to == null) return;

    state = state.copyWith(loading: true, errorMessage: null);

    try {
      final alarms = await _gatewayRepository.fetchAlarms(from: from, to: to);
      state = state.copyWith(loading: false, alarms: alarms);
    } on AppException catch (error) {
      state = state.copyWith(loading: false, errorMessage: error.userMessage);
    }
  }

  void setRange({required DateTime from, required DateTime to}) {
    state = state.copyWith(from: from, to: to);
  }
}
