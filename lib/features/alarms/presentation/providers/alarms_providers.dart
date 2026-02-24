import 'package:axle_tracking_cms/features/alarms/presentation/controllers/alarms_controller.dart';
import 'package:axle_tracking_cms/features/gateway/presentation/providers/gateway_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final alarmsControllerProvider =
    StateNotifierProvider<AlarmsController, AlarmsState>((ref) {
  return AlarmsController(ref.watch(gatewayRepositoryProvider));
});
