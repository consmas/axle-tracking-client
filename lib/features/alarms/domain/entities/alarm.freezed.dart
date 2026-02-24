// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alarm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Alarm _$AlarmFromJson(Map<String, dynamic> json) {
  return _Alarm.fromJson(json);
}

/// @nodoc
mixin _$Alarm {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'vehicle_id')
  String get vehicleId => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'occurred_at')
  DateTime get occurredAt => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _numToDouble)
  double get latitude => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _numToDouble)
  double get longitude => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _severityToString)
  String? get severity => throw _privateConstructorUsedError;

  /// Serializes this Alarm to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Alarm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AlarmCopyWith<Alarm> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlarmCopyWith<$Res> {
  factory $AlarmCopyWith(Alarm value, $Res Function(Alarm) then) =
      _$AlarmCopyWithImpl<$Res, Alarm>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'vehicle_id') String vehicleId,
      String type,
      String message,
      @JsonKey(name: 'occurred_at') DateTime occurredAt,
      @JsonKey(fromJson: _numToDouble) double latitude,
      @JsonKey(fromJson: _numToDouble) double longitude,
      @JsonKey(fromJson: _severityToString) String? severity});
}

/// @nodoc
class _$AlarmCopyWithImpl<$Res, $Val extends Alarm>
    implements $AlarmCopyWith<$Res> {
  _$AlarmCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Alarm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? vehicleId = null,
    Object? type = null,
    Object? message = null,
    Object? occurredAt = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? severity = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleId: null == vehicleId
          ? _value.vehicleId
          : vehicleId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      occurredAt: null == occurredAt
          ? _value.occurredAt
          : occurredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      severity: freezed == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlarmImplCopyWith<$Res> implements $AlarmCopyWith<$Res> {
  factory _$$AlarmImplCopyWith(
          _$AlarmImpl value, $Res Function(_$AlarmImpl) then) =
      __$$AlarmImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'vehicle_id') String vehicleId,
      String type,
      String message,
      @JsonKey(name: 'occurred_at') DateTime occurredAt,
      @JsonKey(fromJson: _numToDouble) double latitude,
      @JsonKey(fromJson: _numToDouble) double longitude,
      @JsonKey(fromJson: _severityToString) String? severity});
}

/// @nodoc
class __$$AlarmImplCopyWithImpl<$Res>
    extends _$AlarmCopyWithImpl<$Res, _$AlarmImpl>
    implements _$$AlarmImplCopyWith<$Res> {
  __$$AlarmImplCopyWithImpl(
      _$AlarmImpl _value, $Res Function(_$AlarmImpl) _then)
      : super(_value, _then);

  /// Create a copy of Alarm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? vehicleId = null,
    Object? type = null,
    Object? message = null,
    Object? occurredAt = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? severity = freezed,
  }) {
    return _then(_$AlarmImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleId: null == vehicleId
          ? _value.vehicleId
          : vehicleId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      occurredAt: null == occurredAt
          ? _value.occurredAt
          : occurredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      severity: freezed == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AlarmImpl implements _Alarm {
  const _$AlarmImpl(
      {required this.id,
      @JsonKey(name: 'vehicle_id') required this.vehicleId,
      required this.type,
      required this.message,
      @JsonKey(name: 'occurred_at') required this.occurredAt,
      @JsonKey(fromJson: _numToDouble) required this.latitude,
      @JsonKey(fromJson: _numToDouble) required this.longitude,
      @JsonKey(fromJson: _severityToString) this.severity});

  factory _$AlarmImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlarmImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'vehicle_id')
  final String vehicleId;
  @override
  final String type;
  @override
  final String message;
  @override
  @JsonKey(name: 'occurred_at')
  final DateTime occurredAt;
  @override
  @JsonKey(fromJson: _numToDouble)
  final double latitude;
  @override
  @JsonKey(fromJson: _numToDouble)
  final double longitude;
  @override
  @JsonKey(fromJson: _severityToString)
  final String? severity;

  @override
  String toString() {
    return 'Alarm(id: $id, vehicleId: $vehicleId, type: $type, message: $message, occurredAt: $occurredAt, latitude: $latitude, longitude: $longitude, severity: $severity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlarmImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.vehicleId, vehicleId) ||
                other.vehicleId == vehicleId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.occurredAt, occurredAt) ||
                other.occurredAt == occurredAt) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.severity, severity) ||
                other.severity == severity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, vehicleId, type, message,
      occurredAt, latitude, longitude, severity);

  /// Create a copy of Alarm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlarmImplCopyWith<_$AlarmImpl> get copyWith =>
      __$$AlarmImplCopyWithImpl<_$AlarmImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlarmImplToJson(
      this,
    );
  }
}

abstract class _Alarm implements Alarm {
  const factory _Alarm(
          {required final String id,
          @JsonKey(name: 'vehicle_id') required final String vehicleId,
          required final String type,
          required final String message,
          @JsonKey(name: 'occurred_at') required final DateTime occurredAt,
          @JsonKey(fromJson: _numToDouble) required final double latitude,
          @JsonKey(fromJson: _numToDouble) required final double longitude,
          @JsonKey(fromJson: _severityToString) final String? severity}) =
      _$AlarmImpl;

  factory _Alarm.fromJson(Map<String, dynamic> json) = _$AlarmImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'vehicle_id')
  String get vehicleId;
  @override
  String get type;
  @override
  String get message;
  @override
  @JsonKey(name: 'occurred_at')
  DateTime get occurredAt;
  @override
  @JsonKey(fromJson: _numToDouble)
  double get latitude;
  @override
  @JsonKey(fromJson: _numToDouble)
  double get longitude;
  @override
  @JsonKey(fromJson: _severityToString)
  String? get severity;

  /// Create a copy of Alarm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlarmImplCopyWith<_$AlarmImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
