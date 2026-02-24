// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VehicleStatusImpl _$$VehicleStatusImplFromJson(Map<String, dynamic> json) =>
    _$VehicleStatusImpl(
      vehicleId: _idFromJson(json['vehicle_id']),
      latitude: _numToDouble(json['latitude']),
      longitude: _numToDouble(json['longitude']),
      speedKmh: _numToDouble(json['speed_kmh']),
      online: _boolFromJson(json['online']),
      updatedAt: _dateTimeFromJson(json['updated_at']),
    );

Map<String, dynamic> _$$VehicleStatusImplToJson(_$VehicleStatusImpl instance) =>
    <String, dynamic>{
      'vehicle_id': instance.vehicleId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'speed_kmh': instance.speedKmh,
      'online': instance.online,
      'updated_at': instance.updatedAt.toIso8601String(),
    };
