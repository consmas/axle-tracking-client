// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicle_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VehicleStatus _$VehicleStatusFromJson(Map<String, dynamic> json) {
  return _VehicleStatus.fromJson(json);
}

/// @nodoc
mixin _$VehicleStatus {
  @JsonKey(name: 'vehicle_id', fromJson: _idFromJson)
  String get vehicleId => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _numToDouble)
  double get latitude => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _numToDouble)
  double get longitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'speed_kmh', fromJson: _numToDouble)
  double get speedKmh => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _boolFromJson)
  bool get online => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at', fromJson: _dateTimeFromJson)
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this VehicleStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VehicleStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VehicleStatusCopyWith<VehicleStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VehicleStatusCopyWith<$Res> {
  factory $VehicleStatusCopyWith(
          VehicleStatus value, $Res Function(VehicleStatus) then) =
      _$VehicleStatusCopyWithImpl<$Res, VehicleStatus>;
  @useResult
  $Res call(
      {@JsonKey(name: 'vehicle_id', fromJson: _idFromJson) String vehicleId,
      @JsonKey(fromJson: _numToDouble) double latitude,
      @JsonKey(fromJson: _numToDouble) double longitude,
      @JsonKey(name: 'speed_kmh', fromJson: _numToDouble) double speedKmh,
      @JsonKey(fromJson: _boolFromJson) bool online,
      @JsonKey(name: 'updated_at', fromJson: _dateTimeFromJson)
      DateTime updatedAt});
}

/// @nodoc
class _$VehicleStatusCopyWithImpl<$Res, $Val extends VehicleStatus>
    implements $VehicleStatusCopyWith<$Res> {
  _$VehicleStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VehicleStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vehicleId = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? speedKmh = null,
    Object? online = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      vehicleId: null == vehicleId
          ? _value.vehicleId
          : vehicleId // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      speedKmh: null == speedKmh
          ? _value.speedKmh
          : speedKmh // ignore: cast_nullable_to_non_nullable
              as double,
      online: null == online
          ? _value.online
          : online // ignore: cast_nullable_to_non_nullable
              as bool,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VehicleStatusImplCopyWith<$Res>
    implements $VehicleStatusCopyWith<$Res> {
  factory _$$VehicleStatusImplCopyWith(
          _$VehicleStatusImpl value, $Res Function(_$VehicleStatusImpl) then) =
      __$$VehicleStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'vehicle_id', fromJson: _idFromJson) String vehicleId,
      @JsonKey(fromJson: _numToDouble) double latitude,
      @JsonKey(fromJson: _numToDouble) double longitude,
      @JsonKey(name: 'speed_kmh', fromJson: _numToDouble) double speedKmh,
      @JsonKey(fromJson: _boolFromJson) bool online,
      @JsonKey(name: 'updated_at', fromJson: _dateTimeFromJson)
      DateTime updatedAt});
}

/// @nodoc
class __$$VehicleStatusImplCopyWithImpl<$Res>
    extends _$VehicleStatusCopyWithImpl<$Res, _$VehicleStatusImpl>
    implements _$$VehicleStatusImplCopyWith<$Res> {
  __$$VehicleStatusImplCopyWithImpl(
      _$VehicleStatusImpl _value, $Res Function(_$VehicleStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of VehicleStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vehicleId = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? speedKmh = null,
    Object? online = null,
    Object? updatedAt = null,
  }) {
    return _then(_$VehicleStatusImpl(
      vehicleId: null == vehicleId
          ? _value.vehicleId
          : vehicleId // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      speedKmh: null == speedKmh
          ? _value.speedKmh
          : speedKmh // ignore: cast_nullable_to_non_nullable
              as double,
      online: null == online
          ? _value.online
          : online // ignore: cast_nullable_to_non_nullable
              as bool,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VehicleStatusImpl implements _VehicleStatus {
  const _$VehicleStatusImpl(
      {@JsonKey(name: 'vehicle_id', fromJson: _idFromJson)
      required this.vehicleId,
      @JsonKey(fromJson: _numToDouble) required this.latitude,
      @JsonKey(fromJson: _numToDouble) required this.longitude,
      @JsonKey(name: 'speed_kmh', fromJson: _numToDouble)
      required this.speedKmh,
      @JsonKey(fromJson: _boolFromJson) required this.online,
      @JsonKey(name: 'updated_at', fromJson: _dateTimeFromJson)
      required this.updatedAt});

  factory _$VehicleStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$VehicleStatusImplFromJson(json);

  @override
  @JsonKey(name: 'vehicle_id', fromJson: _idFromJson)
  final String vehicleId;
  @override
  @JsonKey(fromJson: _numToDouble)
  final double latitude;
  @override
  @JsonKey(fromJson: _numToDouble)
  final double longitude;
  @override
  @JsonKey(name: 'speed_kmh', fromJson: _numToDouble)
  final double speedKmh;
  @override
  @JsonKey(fromJson: _boolFromJson)
  final bool online;
  @override
  @JsonKey(name: 'updated_at', fromJson: _dateTimeFromJson)
  final DateTime updatedAt;

  @override
  String toString() {
    return 'VehicleStatus(vehicleId: $vehicleId, latitude: $latitude, longitude: $longitude, speedKmh: $speedKmh, online: $online, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VehicleStatusImpl &&
            (identical(other.vehicleId, vehicleId) ||
                other.vehicleId == vehicleId) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.speedKmh, speedKmh) ||
                other.speedKmh == speedKmh) &&
            (identical(other.online, online) || other.online == online) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, vehicleId, latitude, longitude, speedKmh, online, updatedAt);

  /// Create a copy of VehicleStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VehicleStatusImplCopyWith<_$VehicleStatusImpl> get copyWith =>
      __$$VehicleStatusImplCopyWithImpl<_$VehicleStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VehicleStatusImplToJson(
      this,
    );
  }
}

abstract class _VehicleStatus implements VehicleStatus {
  const factory _VehicleStatus(
      {@JsonKey(name: 'vehicle_id', fromJson: _idFromJson)
      required final String vehicleId,
      @JsonKey(fromJson: _numToDouble) required final double latitude,
      @JsonKey(fromJson: _numToDouble) required final double longitude,
      @JsonKey(name: 'speed_kmh', fromJson: _numToDouble)
      required final double speedKmh,
      @JsonKey(fromJson: _boolFromJson) required final bool online,
      @JsonKey(name: 'updated_at', fromJson: _dateTimeFromJson)
      required final DateTime updatedAt}) = _$VehicleStatusImpl;

  factory _VehicleStatus.fromJson(Map<String, dynamic> json) =
      _$VehicleStatusImpl.fromJson;

  @override
  @JsonKey(name: 'vehicle_id', fromJson: _idFromJson)
  String get vehicleId;
  @override
  @JsonKey(fromJson: _numToDouble)
  double get latitude;
  @override
  @JsonKey(fromJson: _numToDouble)
  double get longitude;
  @override
  @JsonKey(name: 'speed_kmh', fromJson: _numToDouble)
  double get speedKmh;
  @override
  @JsonKey(fromJson: _boolFromJson)
  bool get online;
  @override
  @JsonKey(name: 'updated_at', fromJson: _dateTimeFromJson)
  DateTime get updatedAt;

  /// Create a copy of VehicleStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VehicleStatusImplCopyWith<_$VehicleStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
