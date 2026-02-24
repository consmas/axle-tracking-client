// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicles_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VehiclesResponseDto _$VehiclesResponseDtoFromJson(Map<String, dynamic> json) {
  return _VehiclesResponseDto.fromJson(json);
}

/// @nodoc
mixin _$VehiclesResponseDto {
  List<Vehicle> get vehicles => throw _privateConstructorUsedError;

  /// Serializes this VehiclesResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VehiclesResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VehiclesResponseDtoCopyWith<VehiclesResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VehiclesResponseDtoCopyWith<$Res> {
  factory $VehiclesResponseDtoCopyWith(
          VehiclesResponseDto value, $Res Function(VehiclesResponseDto) then) =
      _$VehiclesResponseDtoCopyWithImpl<$Res, VehiclesResponseDto>;
  @useResult
  $Res call({List<Vehicle> vehicles});
}

/// @nodoc
class _$VehiclesResponseDtoCopyWithImpl<$Res, $Val extends VehiclesResponseDto>
    implements $VehiclesResponseDtoCopyWith<$Res> {
  _$VehiclesResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VehiclesResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vehicles = null,
  }) {
    return _then(_value.copyWith(
      vehicles: null == vehicles
          ? _value.vehicles
          : vehicles // ignore: cast_nullable_to_non_nullable
              as List<Vehicle>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VehiclesResponseDtoImplCopyWith<$Res>
    implements $VehiclesResponseDtoCopyWith<$Res> {
  factory _$$VehiclesResponseDtoImplCopyWith(_$VehiclesResponseDtoImpl value,
          $Res Function(_$VehiclesResponseDtoImpl) then) =
      __$$VehiclesResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Vehicle> vehicles});
}

/// @nodoc
class __$$VehiclesResponseDtoImplCopyWithImpl<$Res>
    extends _$VehiclesResponseDtoCopyWithImpl<$Res, _$VehiclesResponseDtoImpl>
    implements _$$VehiclesResponseDtoImplCopyWith<$Res> {
  __$$VehiclesResponseDtoImplCopyWithImpl(_$VehiclesResponseDtoImpl _value,
      $Res Function(_$VehiclesResponseDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of VehiclesResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vehicles = null,
  }) {
    return _then(_$VehiclesResponseDtoImpl(
      vehicles: null == vehicles
          ? _value._vehicles
          : vehicles // ignore: cast_nullable_to_non_nullable
              as List<Vehicle>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VehiclesResponseDtoImpl implements _VehiclesResponseDto {
  const _$VehiclesResponseDtoImpl({required final List<Vehicle> vehicles})
      : _vehicles = vehicles;

  factory _$VehiclesResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$VehiclesResponseDtoImplFromJson(json);

  final List<Vehicle> _vehicles;
  @override
  List<Vehicle> get vehicles {
    if (_vehicles is EqualUnmodifiableListView) return _vehicles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vehicles);
  }

  @override
  String toString() {
    return 'VehiclesResponseDto(vehicles: $vehicles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VehiclesResponseDtoImpl &&
            const DeepCollectionEquality().equals(other._vehicles, _vehicles));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_vehicles));

  /// Create a copy of VehiclesResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VehiclesResponseDtoImplCopyWith<_$VehiclesResponseDtoImpl> get copyWith =>
      __$$VehiclesResponseDtoImplCopyWithImpl<_$VehiclesResponseDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VehiclesResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _VehiclesResponseDto implements VehiclesResponseDto {
  const factory _VehiclesResponseDto({required final List<Vehicle> vehicles}) =
      _$VehiclesResponseDtoImpl;

  factory _VehiclesResponseDto.fromJson(Map<String, dynamic> json) =
      _$VehiclesResponseDtoImpl.fromJson;

  @override
  List<Vehicle> get vehicles;

  /// Create a copy of VehiclesResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VehiclesResponseDtoImplCopyWith<_$VehiclesResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
