import 'package:freezed_annotation/freezed_annotation.dart';

part 'alarm.freezed.dart';
part 'alarm.g.dart';

@freezed
class Alarm with _$Alarm {
  const factory Alarm({
    required String id,
    @JsonKey(name: 'vehicle_id') required String vehicleId,
    required String type,
    required String message,
    @JsonKey(name: 'occurred_at') required DateTime occurredAt,
    @JsonKey(fromJson: _numToDouble) required double latitude,
    @JsonKey(fromJson: _numToDouble) required double longitude,
    @JsonKey(fromJson: _severityToString) String? severity,
  }) = _Alarm;

  factory Alarm.fromJson(Map<String, dynamic> json) => _$AlarmFromJson(json);
}

double _numToDouble(Object? value) {
  if (value is num) return value.toDouble();
  return double.tryParse(value?.toString() ?? '') ?? 0;
}

String? _severityToString(Object? value) => value?.toString();
