// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_tracking_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LiveTrackingState {
  bool get loading => throw _privateConstructorUsedError;
  VehicleStatus? get status => throw _privateConstructorUsedError;
  LatLng? get markerPosition => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of LiveTrackingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LiveTrackingStateCopyWith<LiveTrackingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LiveTrackingStateCopyWith<$Res> {
  factory $LiveTrackingStateCopyWith(
          LiveTrackingState value, $Res Function(LiveTrackingState) then) =
      _$LiveTrackingStateCopyWithImpl<$Res, LiveTrackingState>;
  @useResult
  $Res call(
      {bool loading,
      VehicleStatus? status,
      LatLng? markerPosition,
      String? errorMessage});

  $VehicleStatusCopyWith<$Res>? get status;
}

/// @nodoc
class _$LiveTrackingStateCopyWithImpl<$Res, $Val extends LiveTrackingState>
    implements $LiveTrackingStateCopyWith<$Res> {
  _$LiveTrackingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LiveTrackingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? status = freezed,
    Object? markerPosition = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as VehicleStatus?,
      markerPosition: freezed == markerPosition
          ? _value.markerPosition
          : markerPosition // ignore: cast_nullable_to_non_nullable
              as LatLng?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of LiveTrackingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VehicleStatusCopyWith<$Res>? get status {
    if (_value.status == null) {
      return null;
    }

    return $VehicleStatusCopyWith<$Res>(_value.status!, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LiveTrackingStateImplCopyWith<$Res>
    implements $LiveTrackingStateCopyWith<$Res> {
  factory _$$LiveTrackingStateImplCopyWith(_$LiveTrackingStateImpl value,
          $Res Function(_$LiveTrackingStateImpl) then) =
      __$$LiveTrackingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool loading,
      VehicleStatus? status,
      LatLng? markerPosition,
      String? errorMessage});

  @override
  $VehicleStatusCopyWith<$Res>? get status;
}

/// @nodoc
class __$$LiveTrackingStateImplCopyWithImpl<$Res>
    extends _$LiveTrackingStateCopyWithImpl<$Res, _$LiveTrackingStateImpl>
    implements _$$LiveTrackingStateImplCopyWith<$Res> {
  __$$LiveTrackingStateImplCopyWithImpl(_$LiveTrackingStateImpl _value,
      $Res Function(_$LiveTrackingStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LiveTrackingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? status = freezed,
    Object? markerPosition = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$LiveTrackingStateImpl(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as VehicleStatus?,
      markerPosition: freezed == markerPosition
          ? _value.markerPosition
          : markerPosition // ignore: cast_nullable_to_non_nullable
              as LatLng?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LiveTrackingStateImpl implements _LiveTrackingState {
  const _$LiveTrackingStateImpl(
      {this.loading = false,
      this.status,
      this.markerPosition,
      this.errorMessage});

  @override
  @JsonKey()
  final bool loading;
  @override
  final VehicleStatus? status;
  @override
  final LatLng? markerPosition;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'LiveTrackingState(loading: $loading, status: $status, markerPosition: $markerPosition, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LiveTrackingStateImpl &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.markerPosition, markerPosition) ||
                other.markerPosition == markerPosition) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, loading, status, markerPosition, errorMessage);

  /// Create a copy of LiveTrackingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LiveTrackingStateImplCopyWith<_$LiveTrackingStateImpl> get copyWith =>
      __$$LiveTrackingStateImplCopyWithImpl<_$LiveTrackingStateImpl>(
          this, _$identity);
}

abstract class _LiveTrackingState implements LiveTrackingState {
  const factory _LiveTrackingState(
      {final bool loading,
      final VehicleStatus? status,
      final LatLng? markerPosition,
      final String? errorMessage}) = _$LiveTrackingStateImpl;

  @override
  bool get loading;
  @override
  VehicleStatus? get status;
  @override
  LatLng? get markerPosition;
  @override
  String? get errorMessage;

  /// Create a copy of LiveTrackingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LiveTrackingStateImplCopyWith<_$LiveTrackingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
