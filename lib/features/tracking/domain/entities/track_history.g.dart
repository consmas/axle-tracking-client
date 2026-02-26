// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrackPointImpl _$$TrackPointImplFromJson(Map<String, dynamic> json) =>
    _$TrackPointImpl(
      latitude: _latitudeFromJson(json['latitude']),
      longitude: _longitudeFromJson(json['longitude']),
      speedKmh: _numToDouble(json['speed_kmh']),
      recordedAt: _dateTimeFromJson(json['recorded_at']),
    );

Map<String, dynamic> _$$TrackPointImplToJson(_$TrackPointImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'speed_kmh': instance.speedKmh,
      'recorded_at': instance.recordedAt.toIso8601String(),
    };

_$TrackHistoryImpl _$$TrackHistoryImplFromJson(Map<String, dynamic> json) =>
    _$TrackHistoryImpl(
      vehicleId: _idFromJson(json['vehicle_id']),
      from: _dateTimeFromJson(json['from']),
      to: _dateTimeFromJson(json['to']),
      points: _pointsFromJson(json['points']),
    );

Map<String, dynamic> _$$TrackHistoryImplToJson(_$TrackHistoryImpl instance) =>
    <String, dynamic>{
      'vehicle_id': instance.vehicleId,
      'from': instance.from.toIso8601String(),
      'to': instance.to.toIso8601String(),
      'points': instance.points,
    };
