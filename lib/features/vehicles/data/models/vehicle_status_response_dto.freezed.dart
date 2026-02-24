// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicle_status_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VehicleStatusResponseDto _$VehicleStatusResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _VehicleStatusResponseDto.fromJson(json);
}

/// @nodoc
mixin _$VehicleStatusResponseDto {
  @JsonKey(name: 'vehicle_status')
  VehicleStatus get vehicleStatus => throw _privateConstructorUsedError;

  /// Serializes this VehicleStatusResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VehicleStatusResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VehicleStatusResponseDtoCopyWith<VehicleStatusResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VehicleStatusResponseDtoCopyWith<$Res> {
  factory $VehicleStatusResponseDtoCopyWith(VehicleStatusResponseDto value,
          $Res Function(VehicleStatusResponseDto) then) =
      _$VehicleStatusResponseDtoCopyWithImpl<$Res, VehicleStatusResponseDto>;
  @useResult
  $Res call({@JsonKey(name: 'vehicle_status') VehicleStatus vehicleStatus});

  $VehicleStatusCopyWith<$Res> get vehicleStatus;
}

/// @nodoc
class _$VehicleStatusResponseDtoCopyWithImpl<$Res,
        $Val extends VehicleStatusResponseDto>
    implements $VehicleStatusResponseDtoCopyWith<$Res> {
  _$VehicleStatusResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VehicleStatusResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vehicleStatus = null,
  }) {
    return _then(_value.copyWith(
      vehicleStatus: null == vehicleStatus
          ? _value.vehicleStatus
          : vehicleStatus // ignore: cast_nullable_to_non_nullable
              as VehicleStatus,
    ) as $Val);
  }

  /// Create a copy of VehicleStatusResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VehicleStatusCopyWith<$Res> get vehicleStatus {
    return $VehicleStatusCopyWith<$Res>(_value.vehicleStatus, (value) {
      return _then(_value.copyWith(vehicleStatus: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$VehicleStatusResponseDtoImplCopyWith<$Res>
    implements $VehicleStatusResponseDtoCopyWith<$Res> {
  factory _$$VehicleStatusResponseDtoImplCopyWith(
          _$VehicleStatusResponseDtoImpl value,
          $Res Function(_$VehicleStatusResponseDtoImpl) then) =
      __$$VehicleStatusResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'vehicle_status') VehicleStatus vehicleStatus});

  @override
  $VehicleStatusCopyWith<$Res> get vehicleStatus;
}

/// @nodoc
class __$$VehicleStatusResponseDtoImplCopyWithImpl<$Res>
    extends _$VehicleStatusResponseDtoCopyWithImpl<$Res,
        _$VehicleStatusResponseDtoImpl>
    implements _$$VehicleStatusResponseDtoImplCopyWith<$Res> {
  __$$VehicleStatusResponseDtoImplCopyWithImpl(
      _$VehicleStatusResponseDtoImpl _value,
      $Res Function(_$VehicleStatusResponseDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of VehicleStatusResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vehicleStatus = null,
  }) {
    return _then(_$VehicleStatusResponseDtoImpl(
      vehicleStatus: null == vehicleStatus
          ? _value.vehicleStatus
          : vehicleStatus // ignore: cast_nullable_to_non_nullable
              as VehicleStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VehicleStatusResponseDtoImpl implements _VehicleStatusResponseDto {
  const _$VehicleStatusResponseDtoImpl(
      {@JsonKey(name: 'vehicle_status') required this.vehicleStatus});

  factory _$VehicleStatusResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$VehicleStatusResponseDtoImplFromJson(json);

  @override
  @JsonKey(name: 'vehicle_status')
  final VehicleStatus vehicleStatus;

  @override
  String toString() {
    return 'VehicleStatusResponseDto(vehicleStatus: $vehicleStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VehicleStatusResponseDtoImpl &&
            (identical(other.vehicleStatus, vehicleStatus) ||
                other.vehicleStatus == vehicleStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, vehicleStatus);

  /// Create a copy of VehicleStatusResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VehicleStatusResponseDtoImplCopyWith<_$VehicleStatusResponseDtoImpl>
      get copyWith => __$$VehicleStatusResponseDtoImplCopyWithImpl<
          _$VehicleStatusResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VehicleStatusResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _VehicleStatusResponseDto implements VehicleStatusResponseDto {
  const factory _VehicleStatusResponseDto(
          {@JsonKey(name: 'vehicle_status')
          required final VehicleStatus vehicleStatus}) =
      _$VehicleStatusResponseDtoImpl;

  factory _VehicleStatusResponseDto.fromJson(Map<String, dynamic> json) =
      _$VehicleStatusResponseDtoImpl.fromJson;

  @override
  @JsonKey(name: 'vehicle_status')
  VehicleStatus get vehicleStatus;

  /// Create a copy of VehicleStatusResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VehicleStatusResponseDtoImplCopyWith<_$VehicleStatusResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
