// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_feed_vehicle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MapFeedVehicle _$MapFeedVehicleFromJson(Map<String, dynamic> json) {
  return _MapFeedVehicle.fromJson(json);
}

/// @nodoc
mixin _$MapFeedVehicle {
  @JsonKey(fromJson: _idFromJson)
  String get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'plate_number')
  String? get plateNumber => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _boolFromJson)
  bool get online => throw _privateConstructorUsedError;
  MapFeedStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'live_stream')
  MapFeedLiveStream? get liveStream => throw _privateConstructorUsedError;

  /// Serializes this MapFeedVehicle to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MapFeedVehicle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MapFeedVehicleCopyWith<MapFeedVehicle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapFeedVehicleCopyWith<$Res> {
  factory $MapFeedVehicleCopyWith(
          MapFeedVehicle value, $Res Function(MapFeedVehicle) then) =
      _$MapFeedVehicleCopyWithImpl<$Res, MapFeedVehicle>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: _idFromJson) String id,
      String? name,
      @JsonKey(name: 'plate_number') String? plateNumber,
      @JsonKey(fromJson: _boolFromJson) bool online,
      MapFeedStatus status,
      @JsonKey(name: 'live_stream') MapFeedLiveStream? liveStream});

  $MapFeedStatusCopyWith<$Res> get status;
  $MapFeedLiveStreamCopyWith<$Res>? get liveStream;
}

/// @nodoc
class _$MapFeedVehicleCopyWithImpl<$Res, $Val extends MapFeedVehicle>
    implements $MapFeedVehicleCopyWith<$Res> {
  _$MapFeedVehicleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MapFeedVehicle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? plateNumber = freezed,
    Object? online = null,
    Object? status = null,
    Object? liveStream = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      plateNumber: freezed == plateNumber
          ? _value.plateNumber
          : plateNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      online: null == online
          ? _value.online
          : online // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MapFeedStatus,
      liveStream: freezed == liveStream
          ? _value.liveStream
          : liveStream // ignore: cast_nullable_to_non_nullable
              as MapFeedLiveStream?,
    ) as $Val);
  }

  /// Create a copy of MapFeedVehicle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MapFeedStatusCopyWith<$Res> get status {
    return $MapFeedStatusCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }

  /// Create a copy of MapFeedVehicle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MapFeedLiveStreamCopyWith<$Res>? get liveStream {
    if (_value.liveStream == null) {
      return null;
    }

    return $MapFeedLiveStreamCopyWith<$Res>(_value.liveStream!, (value) {
      return _then(_value.copyWith(liveStream: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MapFeedVehicleImplCopyWith<$Res>
    implements $MapFeedVehicleCopyWith<$Res> {
  factory _$$MapFeedVehicleImplCopyWith(_$MapFeedVehicleImpl value,
          $Res Function(_$MapFeedVehicleImpl) then) =
      __$$MapFeedVehicleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: _idFromJson) String id,
      String? name,
      @JsonKey(name: 'plate_number') String? plateNumber,
      @JsonKey(fromJson: _boolFromJson) bool online,
      MapFeedStatus status,
      @JsonKey(name: 'live_stream') MapFeedLiveStream? liveStream});

  @override
  $MapFeedStatusCopyWith<$Res> get status;
  @override
  $MapFeedLiveStreamCopyWith<$Res>? get liveStream;
}

/// @nodoc
class __$$MapFeedVehicleImplCopyWithImpl<$Res>
    extends _$MapFeedVehicleCopyWithImpl<$Res, _$MapFeedVehicleImpl>
    implements _$$MapFeedVehicleImplCopyWith<$Res> {
  __$$MapFeedVehicleImplCopyWithImpl(
      _$MapFeedVehicleImpl _value, $Res Function(_$MapFeedVehicleImpl) _then)
      : super(_value, _then);

  /// Create a copy of MapFeedVehicle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? plateNumber = freezed,
    Object? online = null,
    Object? status = null,
    Object? liveStream = freezed,
  }) {
    return _then(_$MapFeedVehicleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      plateNumber: freezed == plateNumber
          ? _value.plateNumber
          : plateNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      online: null == online
          ? _value.online
          : online // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MapFeedStatus,
      liveStream: freezed == liveStream
          ? _value.liveStream
          : liveStream // ignore: cast_nullable_to_non_nullable
              as MapFeedLiveStream?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MapFeedVehicleImpl implements _MapFeedVehicle {
  const _$MapFeedVehicleImpl(
      {@JsonKey(fromJson: _idFromJson) required this.id,
      this.name,
      @JsonKey(name: 'plate_number') this.plateNumber,
      @JsonKey(fromJson: _boolFromJson) required this.online,
      required this.status,
      @JsonKey(name: 'live_stream') this.liveStream});

  factory _$MapFeedVehicleImpl.fromJson(Map<String, dynamic> json) =>
      _$$MapFeedVehicleImplFromJson(json);

  @override
  @JsonKey(fromJson: _idFromJson)
  final String id;
  @override
  final String? name;
  @override
  @JsonKey(name: 'plate_number')
  final String? plateNumber;
  @override
  @JsonKey(fromJson: _boolFromJson)
  final bool online;
  @override
  final MapFeedStatus status;
  @override
  @JsonKey(name: 'live_stream')
  final MapFeedLiveStream? liveStream;

  @override
  String toString() {
    return 'MapFeedVehicle(id: $id, name: $name, plateNumber: $plateNumber, online: $online, status: $status, liveStream: $liveStream)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapFeedVehicleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.plateNumber, plateNumber) ||
                other.plateNumber == plateNumber) &&
            (identical(other.online, online) || other.online == online) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.liveStream, liveStream) ||
                other.liveStream == liveStream));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, plateNumber, online, status, liveStream);

  /// Create a copy of MapFeedVehicle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MapFeedVehicleImplCopyWith<_$MapFeedVehicleImpl> get copyWith =>
      __$$MapFeedVehicleImplCopyWithImpl<_$MapFeedVehicleImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MapFeedVehicleImplToJson(
      this,
    );
  }
}

abstract class _MapFeedVehicle implements MapFeedVehicle {
  const factory _MapFeedVehicle(
          {@JsonKey(fromJson: _idFromJson) required final String id,
          final String? name,
          @JsonKey(name: 'plate_number') final String? plateNumber,
          @JsonKey(fromJson: _boolFromJson) required final bool online,
          required final MapFeedStatus status,
          @JsonKey(name: 'live_stream') final MapFeedLiveStream? liveStream}) =
      _$MapFeedVehicleImpl;

  factory _MapFeedVehicle.fromJson(Map<String, dynamic> json) =
      _$MapFeedVehicleImpl.fromJson;

  @override
  @JsonKey(fromJson: _idFromJson)
  String get id;
  @override
  String? get name;
  @override
  @JsonKey(name: 'plate_number')
  String? get plateNumber;
  @override
  @JsonKey(fromJson: _boolFromJson)
  bool get online;
  @override
  MapFeedStatus get status;
  @override
  @JsonKey(name: 'live_stream')
  MapFeedLiveStream? get liveStream;

  /// Create a copy of MapFeedVehicle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MapFeedVehicleImplCopyWith<_$MapFeedVehicleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MapFeedStatus _$MapFeedStatusFromJson(Map<String, dynamic> json) {
  return _MapFeedStatus.fromJson(json);
}

/// @nodoc
mixin _$MapFeedStatus {
  @JsonKey(fromJson: _latitudeFromJson)
  double get latitude => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _longitudeFromJson)
  double get longitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'speed_kmh', fromJson: _numToDouble)
  double get speedKmh => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _dateTimeFromJson)
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this MapFeedStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MapFeedStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MapFeedStatusCopyWith<MapFeedStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapFeedStatusCopyWith<$Res> {
  factory $MapFeedStatusCopyWith(
          MapFeedStatus value, $Res Function(MapFeedStatus) then) =
      _$MapFeedStatusCopyWithImpl<$Res, MapFeedStatus>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: _latitudeFromJson) double latitude,
      @JsonKey(fromJson: _longitudeFromJson) double longitude,
      @JsonKey(name: 'speed_kmh', fromJson: _numToDouble) double speedKmh,
      @JsonKey(fromJson: _dateTimeFromJson) DateTime updatedAt});
}

/// @nodoc
class _$MapFeedStatusCopyWithImpl<$Res, $Val extends MapFeedStatus>
    implements $MapFeedStatusCopyWith<$Res> {
  _$MapFeedStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MapFeedStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? speedKmh = null,
    Object? updatedAt = null,
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
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MapFeedStatusImplCopyWith<$Res>
    implements $MapFeedStatusCopyWith<$Res> {
  factory _$$MapFeedStatusImplCopyWith(
          _$MapFeedStatusImpl value, $Res Function(_$MapFeedStatusImpl) then) =
      __$$MapFeedStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: _latitudeFromJson) double latitude,
      @JsonKey(fromJson: _longitudeFromJson) double longitude,
      @JsonKey(name: 'speed_kmh', fromJson: _numToDouble) double speedKmh,
      @JsonKey(fromJson: _dateTimeFromJson) DateTime updatedAt});
}

/// @nodoc
class __$$MapFeedStatusImplCopyWithImpl<$Res>
    extends _$MapFeedStatusCopyWithImpl<$Res, _$MapFeedStatusImpl>
    implements _$$MapFeedStatusImplCopyWith<$Res> {
  __$$MapFeedStatusImplCopyWithImpl(
      _$MapFeedStatusImpl _value, $Res Function(_$MapFeedStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of MapFeedStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? speedKmh = null,
    Object? updatedAt = null,
  }) {
    return _then(_$MapFeedStatusImpl(
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
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MapFeedStatusImpl implements _MapFeedStatus {
  const _$MapFeedStatusImpl(
      {@JsonKey(fromJson: _latitudeFromJson) required this.latitude,
      @JsonKey(fromJson: _longitudeFromJson) required this.longitude,
      @JsonKey(name: 'speed_kmh', fromJson: _numToDouble)
      required this.speedKmh,
      @JsonKey(fromJson: _dateTimeFromJson) required this.updatedAt});

  factory _$MapFeedStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$MapFeedStatusImplFromJson(json);

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
  @JsonKey(fromJson: _dateTimeFromJson)
  final DateTime updatedAt;

  @override
  String toString() {
    return 'MapFeedStatus(latitude: $latitude, longitude: $longitude, speedKmh: $speedKmh, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapFeedStatusImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.speedKmh, speedKmh) ||
                other.speedKmh == speedKmh) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, latitude, longitude, speedKmh, updatedAt);

  /// Create a copy of MapFeedStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MapFeedStatusImplCopyWith<_$MapFeedStatusImpl> get copyWith =>
      __$$MapFeedStatusImplCopyWithImpl<_$MapFeedStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MapFeedStatusImplToJson(
      this,
    );
  }
}

abstract class _MapFeedStatus implements MapFeedStatus {
  const factory _MapFeedStatus(
      {@JsonKey(fromJson: _latitudeFromJson) required final double latitude,
      @JsonKey(fromJson: _longitudeFromJson) required final double longitude,
      @JsonKey(name: 'speed_kmh', fromJson: _numToDouble)
      required final double speedKmh,
      @JsonKey(fromJson: _dateTimeFromJson)
      required final DateTime updatedAt}) = _$MapFeedStatusImpl;

  factory _MapFeedStatus.fromJson(Map<String, dynamic> json) =
      _$MapFeedStatusImpl.fromJson;

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
  @JsonKey(fromJson: _dateTimeFromJson)
  DateTime get updatedAt;

  /// Create a copy of MapFeedStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MapFeedStatusImplCopyWith<_$MapFeedStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MapFeedLiveStream _$MapFeedLiveStreamFromJson(Map<String, dynamic> json) {
  return _MapFeedLiveStream.fromJson(json);
}

/// @nodoc
mixin _$MapFeedLiveStream {
  @JsonKey(name: 'stream_url')
  String? get streamUrl => throw _privateConstructorUsedError;
  String? get protocol => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _nullableIntFromJson)
  int? get channel => throw _privateConstructorUsedError;
  String? get stream => throw _privateConstructorUsedError;

  /// Serializes this MapFeedLiveStream to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MapFeedLiveStream
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MapFeedLiveStreamCopyWith<MapFeedLiveStream> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapFeedLiveStreamCopyWith<$Res> {
  factory $MapFeedLiveStreamCopyWith(
          MapFeedLiveStream value, $Res Function(MapFeedLiveStream) then) =
      _$MapFeedLiveStreamCopyWithImpl<$Res, MapFeedLiveStream>;
  @useResult
  $Res call(
      {@JsonKey(name: 'stream_url') String? streamUrl,
      String? protocol,
      @JsonKey(fromJson: _nullableIntFromJson) int? channel,
      String? stream});
}

/// @nodoc
class _$MapFeedLiveStreamCopyWithImpl<$Res, $Val extends MapFeedLiveStream>
    implements $MapFeedLiveStreamCopyWith<$Res> {
  _$MapFeedLiveStreamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MapFeedLiveStream
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? streamUrl = freezed,
    Object? protocol = freezed,
    Object? channel = freezed,
    Object? stream = freezed,
  }) {
    return _then(_value.copyWith(
      streamUrl: freezed == streamUrl
          ? _value.streamUrl
          : streamUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      protocol: freezed == protocol
          ? _value.protocol
          : protocol // ignore: cast_nullable_to_non_nullable
              as String?,
      channel: freezed == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as int?,
      stream: freezed == stream
          ? _value.stream
          : stream // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MapFeedLiveStreamImplCopyWith<$Res>
    implements $MapFeedLiveStreamCopyWith<$Res> {
  factory _$$MapFeedLiveStreamImplCopyWith(_$MapFeedLiveStreamImpl value,
          $Res Function(_$MapFeedLiveStreamImpl) then) =
      __$$MapFeedLiveStreamImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'stream_url') String? streamUrl,
      String? protocol,
      @JsonKey(fromJson: _nullableIntFromJson) int? channel,
      String? stream});
}

/// @nodoc
class __$$MapFeedLiveStreamImplCopyWithImpl<$Res>
    extends _$MapFeedLiveStreamCopyWithImpl<$Res, _$MapFeedLiveStreamImpl>
    implements _$$MapFeedLiveStreamImplCopyWith<$Res> {
  __$$MapFeedLiveStreamImplCopyWithImpl(_$MapFeedLiveStreamImpl _value,
      $Res Function(_$MapFeedLiveStreamImpl) _then)
      : super(_value, _then);

  /// Create a copy of MapFeedLiveStream
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? streamUrl = freezed,
    Object? protocol = freezed,
    Object? channel = freezed,
    Object? stream = freezed,
  }) {
    return _then(_$MapFeedLiveStreamImpl(
      streamUrl: freezed == streamUrl
          ? _value.streamUrl
          : streamUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      protocol: freezed == protocol
          ? _value.protocol
          : protocol // ignore: cast_nullable_to_non_nullable
              as String?,
      channel: freezed == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as int?,
      stream: freezed == stream
          ? _value.stream
          : stream // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MapFeedLiveStreamImpl implements _MapFeedLiveStream {
  const _$MapFeedLiveStreamImpl(
      {@JsonKey(name: 'stream_url') this.streamUrl,
      this.protocol,
      @JsonKey(fromJson: _nullableIntFromJson) this.channel,
      this.stream});

  factory _$MapFeedLiveStreamImpl.fromJson(Map<String, dynamic> json) =>
      _$$MapFeedLiveStreamImplFromJson(json);

  @override
  @JsonKey(name: 'stream_url')
  final String? streamUrl;
  @override
  final String? protocol;
  @override
  @JsonKey(fromJson: _nullableIntFromJson)
  final int? channel;
  @override
  final String? stream;

  @override
  String toString() {
    return 'MapFeedLiveStream(streamUrl: $streamUrl, protocol: $protocol, channel: $channel, stream: $stream)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapFeedLiveStreamImpl &&
            (identical(other.streamUrl, streamUrl) ||
                other.streamUrl == streamUrl) &&
            (identical(other.protocol, protocol) ||
                other.protocol == protocol) &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.stream, stream) || other.stream == stream));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, streamUrl, protocol, channel, stream);

  /// Create a copy of MapFeedLiveStream
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MapFeedLiveStreamImplCopyWith<_$MapFeedLiveStreamImpl> get copyWith =>
      __$$MapFeedLiveStreamImplCopyWithImpl<_$MapFeedLiveStreamImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MapFeedLiveStreamImplToJson(
      this,
    );
  }
}

abstract class _MapFeedLiveStream implements MapFeedLiveStream {
  const factory _MapFeedLiveStream(
      {@JsonKey(name: 'stream_url') final String? streamUrl,
      final String? protocol,
      @JsonKey(fromJson: _nullableIntFromJson) final int? channel,
      final String? stream}) = _$MapFeedLiveStreamImpl;

  factory _MapFeedLiveStream.fromJson(Map<String, dynamic> json) =
      _$MapFeedLiveStreamImpl.fromJson;

  @override
  @JsonKey(name: 'stream_url')
  String? get streamUrl;
  @override
  String? get protocol;
  @override
  @JsonKey(fromJson: _nullableIntFromJson)
  int? get channel;
  @override
  String? get stream;

  /// Create a copy of MapFeedLiveStream
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MapFeedLiveStreamImplCopyWith<_$MapFeedLiveStreamImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
