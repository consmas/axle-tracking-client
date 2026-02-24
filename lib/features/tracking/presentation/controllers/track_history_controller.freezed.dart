// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'track_history_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TrackHistoryState {
  bool get loading => throw _privateConstructorUsedError;
  TrackHistory? get history => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  DateTime? get from => throw _privateConstructorUsedError;
  DateTime? get to => throw _privateConstructorUsedError;

  /// Create a copy of TrackHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrackHistoryStateCopyWith<TrackHistoryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrackHistoryStateCopyWith<$Res> {
  factory $TrackHistoryStateCopyWith(
          TrackHistoryState value, $Res Function(TrackHistoryState) then) =
      _$TrackHistoryStateCopyWithImpl<$Res, TrackHistoryState>;
  @useResult
  $Res call(
      {bool loading,
      TrackHistory? history,
      String? errorMessage,
      DateTime? from,
      DateTime? to});

  $TrackHistoryCopyWith<$Res>? get history;
}

/// @nodoc
class _$TrackHistoryStateCopyWithImpl<$Res, $Val extends TrackHistoryState>
    implements $TrackHistoryStateCopyWith<$Res> {
  _$TrackHistoryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrackHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? history = freezed,
    Object? errorMessage = freezed,
    Object? from = freezed,
    Object? to = freezed,
  }) {
    return _then(_value.copyWith(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      history: freezed == history
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as TrackHistory?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of TrackHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TrackHistoryCopyWith<$Res>? get history {
    if (_value.history == null) {
      return null;
    }

    return $TrackHistoryCopyWith<$Res>(_value.history!, (value) {
      return _then(_value.copyWith(history: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TrackHistoryStateImplCopyWith<$Res>
    implements $TrackHistoryStateCopyWith<$Res> {
  factory _$$TrackHistoryStateImplCopyWith(_$TrackHistoryStateImpl value,
          $Res Function(_$TrackHistoryStateImpl) then) =
      __$$TrackHistoryStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool loading,
      TrackHistory? history,
      String? errorMessage,
      DateTime? from,
      DateTime? to});

  @override
  $TrackHistoryCopyWith<$Res>? get history;
}

/// @nodoc
class __$$TrackHistoryStateImplCopyWithImpl<$Res>
    extends _$TrackHistoryStateCopyWithImpl<$Res, _$TrackHistoryStateImpl>
    implements _$$TrackHistoryStateImplCopyWith<$Res> {
  __$$TrackHistoryStateImplCopyWithImpl(_$TrackHistoryStateImpl _value,
      $Res Function(_$TrackHistoryStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TrackHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? history = freezed,
    Object? errorMessage = freezed,
    Object? from = freezed,
    Object? to = freezed,
  }) {
    return _then(_$TrackHistoryStateImpl(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      history: freezed == history
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as TrackHistory?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$TrackHistoryStateImpl implements _TrackHistoryState {
  const _$TrackHistoryStateImpl(
      {this.loading = false,
      this.history,
      this.errorMessage,
      this.from,
      this.to});

  @override
  @JsonKey()
  final bool loading;
  @override
  final TrackHistory? history;
  @override
  final String? errorMessage;
  @override
  final DateTime? from;
  @override
  final DateTime? to;

  @override
  String toString() {
    return 'TrackHistoryState(loading: $loading, history: $history, errorMessage: $errorMessage, from: $from, to: $to)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrackHistoryStateImpl &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.history, history) || other.history == history) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, loading, history, errorMessage, from, to);

  /// Create a copy of TrackHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrackHistoryStateImplCopyWith<_$TrackHistoryStateImpl> get copyWith =>
      __$$TrackHistoryStateImplCopyWithImpl<_$TrackHistoryStateImpl>(
          this, _$identity);
}

abstract class _TrackHistoryState implements TrackHistoryState {
  const factory _TrackHistoryState(
      {final bool loading,
      final TrackHistory? history,
      final String? errorMessage,
      final DateTime? from,
      final DateTime? to}) = _$TrackHistoryStateImpl;

  @override
  bool get loading;
  @override
  TrackHistory? get history;
  @override
  String? get errorMessage;
  @override
  DateTime? get from;
  @override
  DateTime? get to;

  /// Create a copy of TrackHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrackHistoryStateImplCopyWith<_$TrackHistoryStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
