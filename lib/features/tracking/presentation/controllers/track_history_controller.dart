import 'package:axle_tracking_cms/core/network/app_exception.dart';
import 'package:axle_tracking_cms/features/tracking/domain/entities/track_history.dart';
import 'package:axle_tracking_cms/features/tracking/domain/repositories/tracking_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'track_history_controller.freezed.dart';

@freezed
class TrackHistoryState with _$TrackHistoryState {
  const factory TrackHistoryState({
    @Default(false) bool loading,
    TrackHistory? history,
    String? errorMessage,
    DateTime? from,
    DateTime? to,
  }) = _TrackHistoryState;
}

class TrackHistoryController extends StateNotifier<TrackHistoryState> {
  TrackHistoryController({required this.vehicleId, required this.repository})
      : super(
          TrackHistoryState(
            from: DateTime.now().subtract(const Duration(hours: 6)),
            to: DateTime.now(),
          ),
        );

  final String vehicleId;
  final TrackingRepository repository;

  Future<void> fetch() async {
    final from = state.from;
    final to = state.to;
    if (from == null || to == null) return;

    state = state.copyWith(loading: true, errorMessage: null);
    try {
      final history = await repository.fetchTrackHistory(
        vehicleId: vehicleId,
        from: from,
        to: to,
      );
      state = state.copyWith(loading: false, history: history);
    } on AppException catch (error) {
      state = state.copyWith(loading: false, errorMessage: error.userMessage);
    }
  }

  void setRange({required DateTime from, required DateTime to}) {
    state = state.copyWith(from: from, to: to);
  }
}
