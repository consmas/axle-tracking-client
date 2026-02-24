// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VehicleImpl _$$VehicleImplFromJson(Map<String, dynamic> json) =>
    _$VehicleImpl(
      id: _idFromJson(json['id']),
      name: json['name'] as String?,
      plateNumber: json['plate_number'] as String?,
      online: _onlineFromJson(json['online']),
    );

Map<String, dynamic> _$$VehicleImplToJson(_$VehicleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'plate_number': instance.plateNumber,
      'online': instance.online,
    };
