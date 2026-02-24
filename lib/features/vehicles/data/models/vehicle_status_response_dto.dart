import 'package:axle_tracking_cms/features/vehicles/domain/entities/vehicle_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle_status_response_dto.freezed.dart';
part 'vehicle_status_response_dto.g.dart';

@freezed
class VehicleStatusResponseDto with _$VehicleStatusResponseDto {
  const factory VehicleStatusResponseDto({
    @JsonKey(name: 'vehicle_status') required VehicleStatus vehicleStatus,
  }) = _VehicleStatusResponseDto;

  factory VehicleStatusResponseDto.fromJson(Map<String, dynamic> json) =>
      _$VehicleStatusResponseDtoFromJson(json);
}
