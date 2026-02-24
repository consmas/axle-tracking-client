// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_status_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VehicleStatusResponseDtoImpl _$$VehicleStatusResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$VehicleStatusResponseDtoImpl(
      vehicleStatus: VehicleStatus.fromJson(
          json['vehicle_status'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$VehicleStatusResponseDtoImplToJson(
        _$VehicleStatusResponseDtoImpl instance) =>
    <String, dynamic>{
      'vehicle_status': instance.vehicleStatus,
    };
