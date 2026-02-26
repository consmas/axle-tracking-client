// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'track_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TrackPoint _$TrackPointFromJson(Map<String, dynamic> json) {
  return _TrackPoint.fromJson(json);
}

/// @nodoc
mixin _$TrackPoint {
  @JsonKey(fromJson: _latitudeFromJson)
  double get latitude => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _longitudeFromJson)
  double get longitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'speed_kmh', fromJson: _numToDouble)
  double get speedKmh => throw _privateConstructorUsedError;
  @JsonKey(name: 'recorded_at', fromJson: _dateTimeFromJson)
  DateTime get recordedAt => throw _privateConstructorUsedError;

  /// Serializes this TrackPoint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TrackPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrackPointCopyWith<TrackPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrackPointCopyWith<$Res> {
  factory $TrackPointCopyWith(
          TrackPoint value, $Res Function(TrackPoint) then) =
      _$TrackPointCopyWithImpl<$Res, TrackPoint>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: _latitudeFromJson) double latitude,
      @JsonKey(fromJson: _longitudeFromJson) double longitude,
      @JsonKey(name: 'speed_kmh', fromJson: _numToDouble) double speedKmh,
      @JsonKey(name: 'recorded_at', fromJson: _dateTimeFromJson)
      DateTime recordedAt});
}

/// @nodoc
class _$TrackPointCopyWithImpl<$Res, $Val extends TrackPoint>
    implements $TrackPointCopyWith<$Res> {
  _$TrackPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrackPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? speedKmh = null,
    Object? recordedAt = null,
  }) {
    return _then(_value.copyWith(
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
      recordedAt: null == recordedAt
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrackPointImplCopyWith<$Res>
    implements $TrackPointCopyWith<$Res> {
  factory _$$TrackPointImplCopyWith(
          _$TrackPointImpl value, $Res Function(_$TrackPointImpl) then) =
      __$$TrackPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: _latitudeFromJson) double latitude,
      @JsonKey(fromJson: _longitudeFromJson) double longitude,
      @JsonKey(name: 'speed_kmh', fromJson: _numToDouble) double speedKmh,
      @JsonKey(name: 'recorded_at', fromJson: _dateTimeFromJson)
      DateTime recordedAt});
}

/// @nodoc
class __$$TrackPointImplCopyWithImpl<$Res>
    extends _$TrackPointCopyWithImpl<$Res, _$TrackPointImpl>
    implements _$$TrackPointImplCopyWith<$Res> {
  __$$TrackPointImplCopyWithImpl(
      _$TrackPointImpl _value, $Res Function(_$TrackPointImpl) _then)
      : super(_value, _then);

  /// Create a copy of TrackPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? speedKmh = null,
    Object? recordedAt = null,
  }) {
    return _then(_$TrackPointImpl(
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
      recordedAt: null == recordedAt
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrackPointImpl implements _TrackPoint {
  const _$TrackPointImpl(
      {@JsonKey(fromJson: _latitudeFromJson) required this.latitude,
      @JsonKey(fromJson: _longitudeFromJson) required this.longitude,
      @JsonKey(name: 'speed_kmh', fromJson: _numToDouble)
      required this.speedKmh,
      @JsonKey(name: 'recorded_at', fromJson: _dateTimeFromJson)
      required this.recordedAt});

  factory _$TrackPointImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrackPointImplFromJson(json);

  @override
  @JsonKey(fromJson: _latitudeFromJson)
  final double latitude;
  @override
  @JsonKey(fromJson: _longitudeFromJson)
  final double longitude;
  @override
  @JsonKey(name: 'speed_kmh', fromJson: _numToDouble)
  final double speedKmh;
  @override
  @JsonKey(name: 'recorded_at', fromJson: _dateTimeFromJson)
  final DateTime recordedAt;

  @override
  String toString() {
    return 'TrackPoint(latitude: $latitude, longitude: $longitude, speedKmh: $speedKmh, recordedAt: $recordedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrackPointImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.speedKmh, speedKmh) ||
                other.speedKmh == speedKmh) &&
            (identical(other.recordedAt, recordedAt) ||
                other.recordedAt == recordedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, latitude, longitude, speedKmh, recordedAt);

  /// Create a copy of TrackPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrackPointImplCopyWith<_$TrackPointImpl> get copyWith =>
      __$$TrackPointImplCopyWithImpl<_$TrackPointImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrackPointImplToJson(
      this,
    );
  }
}

abstract class _TrackPoint implements TrackPoint {
  const factory _TrackPoint(
      {@JsonKey(fromJson: _latitudeFromJson) required final double latitude,
      @JsonKey(fromJson: _longitudeFromJson) required final double longitude,
      @JsonKey(name: 'speed_kmh', fromJson: _numToDouble)
      required final double speedKmh,
      @JsonKey(name: 'recorded_at', fromJson: _dateTimeFromJson)
      required final DateTime recordedAt}) = _$TrackPointImpl;

  factory _TrackPoint.fromJson(Map<String, dynamic> json) =
      _$TrackPointImpl.fromJson;

  @override
  @JsonKey(fromJson: _latitudeFromJson)
  double get latitude;
  @override
  @JsonKey(fromJson: _longitudeFromJson)
  double get longitude;
  @override
  @JsonKey(name: 'speed_kmh', fromJson: _numToDouble)
  double get speedKmh;
  @override
  @JsonKey(name: 'recorded_at', fromJson: _dateTimeFromJson)
  DateTime get recordedAt;

  /// Create a copy of TrackPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrackPointImplCopyWith<_$TrackPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TrackHistory _$TrackHistoryFromJson(Map<String, dynamic> json) {
  return _TrackHistory.fromJson(json);
}

/// @nodoc
mixin _$TrackHistory {
  @JsonKey(name: 'vehicle_id', fromJson: _idFromJson)
  String get vehicleId => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _dateTimeFromJson)
  DateTime get from => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _dateTimeFromJson)
  DateTime get to => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _pointsFromJson)
  List<TrackPoint> get points => throw _privateConstructorUsedError;

  /// Serializes this TrackHistory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TrackHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrackHistoryCopyWith<TrackHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrackHistoryCopyWith<$Res> {
  factory $TrackHistoryCopyWith(
          TrackHistory value, $Res Function(TrackHistory) then) =
      _$TrackHistoryCopyWithImpl<$Res, TrackHistory>;
  @useResult
  $Res call(
      {@JsonKey(name: 'vehicle_id', fromJson: _idFromJson) String vehicleId,
      @JsonKey(fromJson: _dateTimeFromJson) DateTime from,
      @JsonKey(fromJson: _dateTimeFromJson) DateTime to,
      @JsonKey(fromJson: _pointsFromJson) List<TrackPoint> points});
}

/// @nodoc
class _$TrackHistoryCopyWithImpl<$Res, $Val extends TrackHistory>
    implements $TrackHistoryCopyWith<$Res> {
  _$TrackHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrackHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vehicleId = null,
    Object? from = null,
    Object? to = null,
    Object? points = null,
  }) {
    return _then(_value.copyWith(
      vehicleId: null == vehicleId
          ? _value.vehicleId
          : vehicleId // ignore: cast_nullable_to_non_nullable
              as String,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as DateTime,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as DateTime,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as List<TrackPoint>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrackHistoryImplCopyWith<$Res>
    implements $TrackHistoryCopyWith<$Res> {
  factory _$$TrackHistoryImplCopyWith(
          _$TrackHistoryImpl value, $Res Function(_$TrackHistoryImpl) then) =
      __$$TrackHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'vehicle_id', fromJson: _idFromJson) String vehicleId,
      @JsonKey(fromJson: _dateTimeFromJson) DateTime from,
      @JsonKey(fromJson: _dateTimeFromJson) DateTime to,
      @JsonKey(fromJson: _pointsFromJson) List<TrackPoint> points});
}

/// @nodoc
class __$$TrackHistoryImplCopyWithImpl<$Res>
    extends _$TrackHistoryCopyWithImpl<$Res, _$TrackHistoryImpl>
    implements _$$TrackHistoryImplCopyWith<$Res> {
  __$$TrackHistoryImplCopyWithImpl(
      _$TrackHistoryImpl _value, $Res Function(_$TrackHistoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of TrackHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vehicleId = null,
    Object? from = null,
    Object? to = null,
    Object? points = null,
  }) {
    return _then(_$TrackHistoryImpl(
      vehicleId: null == vehicleId
          ? _value.vehicleId
          : vehicleId // ignore: cast_nullable_to_non_nullable
              as String,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as DateTime,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as DateTime,
      points: null == points
          ? _value._points
          : points // ignore: cast_nullable_to_non_nullable
              as List<TrackPoint>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrackHistoryImpl implements _TrackHistory {
  const _$TrackHistoryImpl(
      {@JsonKey(name: 'vehicle_id', fromJson: _idFromJson)
      required this.vehicleId,
      @JsonKey(fromJson: _dateTimeFromJson) required this.from,
      @JsonKey(fromJson: _dateTimeFromJson) required this.to,
      @JsonKey(fromJson: _pointsFromJson)
      required final List<TrackPoint> points})
      : _points = points;

  factory _$TrackHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrackHistoryImplFromJson(json);

  @override
  @JsonKey(name: 'vehicle_id', fromJson: _idFromJson)
  final String vehicleId;
  @override
  @JsonKey(fromJson: _dateTimeFromJson)
  final DateTime from;
  @override
  @JsonKey(fromJson: _dateTimeFromJson)
  final DateTime to;
  final List<TrackPoint> _points;
  @override
  @JsonKey(fromJson: _pointsFromJson)
  List<TrackPoint> get points {
    if (_points is EqualUnmodifiableListView) return _points;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_points);
  }

  @override
  String toString() {
    return 'TrackHistory(vehicleId: $vehicleId, from: $from, to: $to, points: $points)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrackHistoryImpl &&
            (identical(other.vehicleId, vehicleId) ||
                other.vehicleId == vehicleId) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            const DeepCollectionEquality().equals(other._points, _points));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, vehicleId, from, to,
      const DeepCollectionEquality().hash(_points));

  /// Create a copy of TrackHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrackHistoryImplCopyWith<_$TrackHistoryImpl> get copyWith =>
      __$$TrackHistoryImplCopyWithImpl<_$TrackHistoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrackHistoryImplToJson(
      this,
    );
  }
}

abstract class _TrackHistory implements TrackHistory {
  const factory _TrackHistory(
      {@JsonKey(name: 'vehicle_id', fromJson: _idFromJson)
      required final String vehicleId,
      @JsonKey(fromJson: _dateTimeFromJson) required final DateTime from,
      @JsonKey(fromJson: _dateTimeFromJson) required final DateTime to,
      @JsonKey(fromJson: _pointsFromJson)
      required final List<TrackPoint> points}) = _$TrackHistoryImpl;

  factory _TrackHistory.fromJson(Map<String, dynamic> json) =
      _$TrackHistoryImpl.fromJson;

  @override
  @JsonKey(name: 'vehicle_id', fromJson: _idFromJson)
  String get vehicleId;
  @override
  @JsonKey(fromJson: _dateTimeFromJson)
  DateTime get from;
  @override
  @JsonKey(fromJson: _dateTimeFromJson)
  DateTime get to;
  @override
  @JsonKey(fromJson: _pointsFromJson)
  List<TrackPoint> get points;

  /// Create a copy of TrackHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrackHistoryImplCopyWith<_$TrackHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
