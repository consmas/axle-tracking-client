// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alarms_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AlarmsState {
  bool get loading => throw _privateConstructorUsedError;
  List<Alarm> get alarms => throw _privateConstructorUsedError;
  DateTime? get from => throw _privateConstructorUsedError;
  DateTime? get to => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of AlarmsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AlarmsStateCopyWith<AlarmsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlarmsStateCopyWith<$Res> {
  factory $AlarmsStateCopyWith(
          AlarmsState value, $Res Function(AlarmsState) then) =
      _$AlarmsStateCopyWithImpl<$Res, AlarmsState>;
  @useResult
  $Res call(
      {bool loading,
      List<Alarm> alarms,
      DateTime? from,
      DateTime? to,
      String? errorMessage});
}

/// @nodoc
class _$AlarmsStateCopyWithImpl<$Res, $Val extends AlarmsState>
    implements $AlarmsStateCopyWith<$Res> {
  _$AlarmsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AlarmsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? alarms = null,
    Object? from = freezed,
    Object? to = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      alarms: null == alarms
          ? _value.alarms
          : alarms // ignore: cast_nullable_to_non_nullable
              as List<Alarm>,
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlarmsStateImplCopyWith<$Res>
    implements $AlarmsStateCopyWith<$Res> {
  factory _$$AlarmsStateImplCopyWith(
          _$AlarmsStateImpl value, $Res Function(_$AlarmsStateImpl) then) =
      __$$AlarmsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool loading,
      List<Alarm> alarms,
      DateTime? from,
      DateTime? to,
      String? errorMessage});
}

/// @nodoc
class __$$AlarmsStateImplCopyWithImpl<$Res>
    extends _$AlarmsStateCopyWithImpl<$Res, _$AlarmsStateImpl>
    implements _$$AlarmsStateImplCopyWith<$Res> {
  __$$AlarmsStateImplCopyWithImpl(
      _$AlarmsStateImpl _value, $Res Function(_$AlarmsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AlarmsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? alarms = null,
    Object? from = freezed,
    Object? to = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$AlarmsStateImpl(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      alarms: null == alarms
          ? _value._alarms
          : alarms // ignore: cast_nullable_to_non_nullable
              as List<Alarm>,
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AlarmsStateImpl implements _AlarmsState {
  const _$AlarmsStateImpl(
      {this.loading = false,
      final List<Alarm> alarms = const [],
      this.from,
      this.to,
      this.errorMessage})
      : _alarms = alarms;

  @override
  @JsonKey()
  final bool loading;
  final List<Alarm> _alarms;
  @override
  @JsonKey()
  List<Alarm> get alarms {
    if (_alarms is EqualUnmodifiableListView) return _alarms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_alarms);
  }

  @override
  final DateTime? from;
  @override
  final DateTime? to;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'AlarmsState(loading: $loading, alarms: $alarms, from: $from, to: $to, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlarmsStateImpl &&
            (identical(other.loading, loading) || other.loading == loading) &&
            const DeepCollectionEquality().equals(other._alarms, _alarms) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, loading,
      const DeepCollectionEquality().hash(_alarms), from, to, errorMessage);

  /// Create a copy of AlarmsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlarmsStateImplCopyWith<_$AlarmsStateImpl> get copyWith =>
      __$$AlarmsStateImplCopyWithImpl<_$AlarmsStateImpl>(this, _$identity);
}

abstract class _AlarmsState implements AlarmsState {
  const factory _AlarmsState(
      {final bool loading,
      final List<Alarm> alarms,
      final DateTime? from,
      final DateTime? to,
      final String? errorMessage}) = _$AlarmsStateImpl;

  @override
  bool get loading;
  @override
  List<Alarm> get alarms;
  @override
  DateTime? get from;
  @override
  DateTime? get to;
  @override
  String? get errorMessage;

  /// Create a copy of AlarmsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlarmsStateImplCopyWith<_$AlarmsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
