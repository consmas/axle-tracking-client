import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle.freezed.dart';
part 'vehicle.g.dart';

@freezed
class Vehicle with _$Vehicle {
  const factory Vehicle({
    @JsonKey(fromJson: _idFromJson) required String id,
    String? name,
    @JsonKey(name: 'plate_number') String? plateNumber,
    @JsonKey(fromJson: _onlineFromJson) required bool online,
  }) = _Vehicle;

  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);
}

String _idFromJson(Object? value) => value?.toString() ?? '';

bool _onlineFromJson(Object? value) => value == true;
