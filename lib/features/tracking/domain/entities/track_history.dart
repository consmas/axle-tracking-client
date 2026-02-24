import 'package:freezed_annotation/freezed_annotation.dart';

part 'track_history.freezed.dart';
part 'track_history.g.dart';

@freezed
class TrackPoint with _$TrackPoint {
  const factory TrackPoint({
    @JsonKey(fromJson: _numToDouble) required double latitude,
    @JsonKey(fromJson: _numToDouble) required double longitude,
    @JsonKey(name: 'speed_kmh', fromJson: _numToDouble)
    required double speedKmh,
    @JsonKey(name: 'recorded_at', fromJson: _dateTimeFromJson)
    required DateTime recordedAt,
  }) = _TrackPoint;

  factory TrackPoint.fromJson(Map<String, dynamic> json) =>
      _$TrackPointFromJson(json);
}

@freezed
class TrackHistory with _$TrackHistory {
  const factory TrackHistory({
    @JsonKey(name: 'vehicle_id', fromJson: _idFromJson)
    required String vehicleId,
    @JsonKey(fromJson: _dateTimeFromJson) required DateTime from,
    @JsonKey(fromJson: _dateTimeFromJson) required DateTime to,
    @JsonKey(fromJson: _pointsFromJson) required List<TrackPoint> points,
  }) = _TrackHistory;

  factory TrackHistory.fromJson(Map<String, dynamic> json) =>
      _$TrackHistoryFromJson(json);
}

double _numToDouble(Object? value) {
  if (value is num) return value.toDouble();
  return double.tryParse(value?.toString() ?? '') ?? 0;
}

String _idFromJson(Object? value) => value?.toString() ?? '';

DateTime _dateTimeFromJson(Object? value) {
  if (value == null) return DateTime.fromMillisecondsSinceEpoch(0);
  if (value is DateTime) return value;
  if (value is num) {
    return DateTime.fromMillisecondsSinceEpoch(value.toInt() * 1000,
            isUtc: true)
        .toLocal();
  }
  return DateTime.tryParse(value.toString()) ??
      DateTime.fromMillisecondsSinceEpoch(0);
}

List<TrackPoint> _pointsFromJson(Object? value) {
  if (value is! List) return const [];
  return value
      .whereType<Map<String, dynamic>>()
      .map(TrackPoint.fromJson)
      .toList(growable: false);
}
