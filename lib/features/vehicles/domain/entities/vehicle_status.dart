import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle_status.freezed.dart';
part 'vehicle_status.g.dart';

@freezed
class VehicleStatus with _$VehicleStatus {
  const factory VehicleStatus({
    @JsonKey(name: 'vehicle_id', fromJson: _idFromJson)
    required String vehicleId,
    @JsonKey(fromJson: _numToDouble) required double latitude,
    @JsonKey(fromJson: _numToDouble) required double longitude,
    @JsonKey(name: 'speed_kmh', fromJson: _numToDouble)
    required double speedKmh,
    @JsonKey(fromJson: _boolFromJson) required bool online,
    @JsonKey(name: 'updated_at', fromJson: _dateTimeFromJson)
    required DateTime updatedAt,
  }) = _VehicleStatus;

  factory VehicleStatus.fromJson(Map<String, dynamic> json) =>
      _$VehicleStatusFromJson(json);
}

double _numToDouble(Object? value) {
  if (value is num) return value.toDouble();
  return double.tryParse(value?.toString() ?? '') ?? 0;
}

String _idFromJson(Object? value) => value?.toString() ?? '';

bool _boolFromJson(Object? value) => value == true;

DateTime _dateTimeFromJson(Object? value) {
  if (value == null) return DateTime.fromMillisecondsSinceEpoch(0);
  return DateTime.tryParse(value.toString()) ??
      DateTime.fromMillisecondsSinceEpoch(0);
}
