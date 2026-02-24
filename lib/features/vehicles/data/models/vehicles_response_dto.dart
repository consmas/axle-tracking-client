import 'package:axle_tracking_cms/features/vehicles/domain/entities/vehicle.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicles_response_dto.freezed.dart';
part 'vehicles_response_dto.g.dart';

@freezed
class VehiclesResponseDto with _$VehiclesResponseDto {
  const factory VehiclesResponseDto({required List<Vehicle> vehicles}) =
      _VehiclesResponseDto;

  factory VehiclesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$VehiclesResponseDtoFromJson(json);
}
