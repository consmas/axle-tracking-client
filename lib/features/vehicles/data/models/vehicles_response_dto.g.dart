// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicles_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VehiclesResponseDtoImpl _$$VehiclesResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$VehiclesResponseDtoImpl(
      vehicles: (json['vehicles'] as List<dynamic>)
          .map((e) => Vehicle.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$VehiclesResponseDtoImplToJson(
        _$VehiclesResponseDtoImpl instance) =>
    <String, dynamic>{
      'vehicles': instance.vehicles,
    };
