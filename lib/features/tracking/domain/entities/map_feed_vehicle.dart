import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_feed_vehicle.freezed.dart';
part 'map_feed_vehicle.g.dart';

@freezed
class MapFeedVehicle with _$MapFeedVehicle {
  const factory MapFeedVehicle({
    @JsonKey(fromJson: _idFromJson) required String id,
    String? name,
    @JsonKey(name: 'plate_number') String? plateNumber,
    @JsonKey(fromJson: _boolFromJson) required bool online,
    required MapFeedStatus status,
    @JsonKey(name: 'live_stream') MapFeedLiveStream? liveStream,
  }) = _MapFeedVehicle;

  factory MapFeedVehicle.fromJson(Map<String, dynamic> json) =>
      _$MapFeedVehicleFromJson(json);
}

@freezed
class MapFeedStatus with _$MapFeedStatus {
  const factory MapFeedStatus({
    @JsonKey(fromJson: _numToDouble) required double latitude,
    @JsonKey(fromJson: _numToDouble) required double longitude,
    @JsonKey(name: 'speed_kmh', fromJson: _numToDouble)
    required double speedKmh,
    @JsonKey(fromJson: _dateTimeFromJson) required DateTime updatedAt,
  }) = _MapFeedStatus;

  factory MapFeedStatus.fromJson(Map<String, dynamic> json) =>
      _$MapFeedStatusFromJson(json);
}

@freezed
class MapFeedLiveStream with _$MapFeedLiveStream {
  const factory MapFeedLiveStream({
    @JsonKey(name: 'stream_url') String? streamUrl,
    String? protocol,
    @JsonKey(fromJson: _nullableIntFromJson) int? channel,
    String? stream,
  }) = _MapFeedLiveStream;

  factory MapFeedLiveStream.fromJson(Map<String, dynamic> json) =>
      _$MapFeedLiveStreamFromJson(json);
}

String _idFromJson(Object? value) => value?.toString() ?? '';

bool _boolFromJson(Object? value) => value == true;

double _numToDouble(Object? value) {
  if (value is num) return value.toDouble();
  return double.tryParse(value?.toString() ?? '') ?? 0;
}

DateTime _dateTimeFromJson(Object? value) {
  if (value == null) return DateTime.fromMillisecondsSinceEpoch(0);
  return DateTime.tryParse(value.toString()) ??
      DateTime.fromMillisecondsSinceEpoch(0);
}

int? _nullableIntFromJson(Object? value) {
  if (value == null) return null;
  if (value is int) return value;
  return int.tryParse(value.toString());
}
