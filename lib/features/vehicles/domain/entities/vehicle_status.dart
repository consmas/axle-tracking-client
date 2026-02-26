import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle_status.freezed.dart';
part 'vehicle_status.g.dart';

@freezed
class VehicleStatus with _$VehicleStatus {
  const factory VehicleStatus({
    @JsonKey(name: 'vehicle_id', fromJson: _idFromJson)
    required String vehicleId,
    @JsonKey(fromJson: _latitudeFromJson) required double latitude,
    @JsonKey(fromJson: _longitudeFromJson) required double longitude,
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

double _latitudeFromJson(Object? value) =>
    _coordinateFromJson(value, isLatitude: true);

double _longitudeFromJson(Object? value) =>
    _coordinateFromJson(value, isLatitude: false);

double _coordinateFromJson(
  Object? value, {
  required bool isLatitude,
}) {
  final raw = _numToDouble(value);
  final limit = isLatitude ? 90.0 : 180.0;

  if (raw == 0) return 0;
  if (raw.abs() <= limit) return raw;

  final asInt = raw.toInt();
  final digits = asInt.abs().toString().length;

  if (digits >= 7) {
    final scaled1m = raw / 1000000.0;
    if (scaled1m.abs() <= limit) return scaled1m;
  }

  if (digits >= 5 && digits <= 6) {
    final scaled100k = raw / 100000.0;
    if (scaled100k.abs() <= limit) return scaled100k;
  }

  if (digits <= 4) {
    final scaled1m = raw / 1000000.0;
    if (scaled1m.abs() <= limit) return scaled1m;
  }

  final scaled100k = raw / 100000.0;
  if (scaled100k.abs() <= limit) return scaled100k;

  final scaled1m = raw / 1000000.0;
  if (scaled1m.abs() <= limit) return scaled1m;

  return raw;
}

String _idFromJson(Object? value) => value?.toString() ?? '';

bool _boolFromJson(Object? value) => value == true;

DateTime _dateTimeFromJson(Object? value) {
  if (value == null) return DateTime.fromMillisecondsSinceEpoch(0);
  return DateTime.tryParse(value.toString()) ??
      DateTime.fromMillisecondsSinceEpoch(0);
}
