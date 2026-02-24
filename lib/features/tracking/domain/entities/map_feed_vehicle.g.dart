// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_feed_vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MapFeedVehicleImpl _$$MapFeedVehicleImplFromJson(Map<String, dynamic> json) =>
    _$MapFeedVehicleImpl(
      id: _idFromJson(json['id']),
      name: json['name'] as String?,
      plateNumber: json['plate_number'] as String?,
      online: _boolFromJson(json['online']),
      status: MapFeedStatus.fromJson(json['status'] as Map<String, dynamic>),
      liveStream: json['live_stream'] == null
          ? null
          : MapFeedLiveStream.fromJson(
              json['live_stream'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MapFeedVehicleImplToJson(
        _$MapFeedVehicleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'plate_number': instance.plateNumber,
      'online': instance.online,
      'status': instance.status,
      'live_stream': instance.liveStream,
    };

_$MapFeedStatusImpl _$$MapFeedStatusImplFromJson(Map<String, dynamic> json) =>
    _$MapFeedStatusImpl(
      latitude: _numToDouble(json['latitude']),
      longitude: _numToDouble(json['longitude']),
      speedKmh: _numToDouble(json['speed_kmh']),
      updatedAt: _dateTimeFromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$MapFeedStatusImplToJson(_$MapFeedStatusImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'speed_kmh': instance.speedKmh,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$MapFeedLiveStreamImpl _$$MapFeedLiveStreamImplFromJson(
        Map<String, dynamic> json) =>
    _$MapFeedLiveStreamImpl(
      streamUrl: json['stream_url'] as String?,
      protocol: json['protocol'] as String?,
      channel: _nullableIntFromJson(json['channel']),
      stream: json['stream'] as String?,
    );

Map<String, dynamic> _$$MapFeedLiveStreamImplToJson(
        _$MapFeedLiveStreamImpl instance) =>
    <String, dynamic>{
      'stream_url': instance.streamUrl,
      'protocol': instance.protocol,
      'channel': instance.channel,
      'stream': instance.stream,
    };
