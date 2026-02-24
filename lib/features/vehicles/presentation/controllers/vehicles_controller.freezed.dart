// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicles_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VehiclesState {
  bool get loading => throw _privateConstructorUsedError;
  List<Vehicle> get vehicles => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of VehiclesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VehiclesStateCopyWith<VehiclesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VehiclesStateCopyWith<$Res> {
  factory $VehiclesStateCopyWith(
          VehiclesState value, $Res Function(VehiclesState) then) =
      _$VehiclesStateCopyWithImpl<$Res, VehiclesState>;
  @useResult
  $Res call({bool loading, List<Vehicle> vehicles, String? errorMessage});
}

/// @nodoc
class _$VehiclesStateCopyWithImpl<$Res, $Val extends VehiclesState>
    implements $VehiclesStateCopyWith<$Res> {
  _$VehiclesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VehiclesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? vehicles = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      vehicles: null == vehicles
          ? _value.vehicles
          : vehicles // ignore: cast_nullable_to_non_nullable
              as List<Vehicle>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VehiclesStateImplCopyWith<$Res>
    implements $VehiclesStateCopyWith<$Res> {
  factory _$$VehiclesStateImplCopyWith(
          _$VehiclesStateImpl value, $Res Function(_$VehiclesStateImpl) then) =
      __$$VehiclesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool loading, List<Vehicle> vehicles, String? errorMessage});
}

/// @nodoc
class __$$VehiclesStateImplCopyWithImpl<$Res>
    extends _$VehiclesStateCopyWithImpl<$Res, _$VehiclesStateImpl>
    implements _$$VehiclesStateImplCopyWith<$Res> {
  __$$VehiclesStateImplCopyWithImpl(
      _$VehiclesStateImpl _value, $Res Function(_$VehiclesStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of VehiclesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? vehicles = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$VehiclesStateImpl(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      vehicles: null == vehicles
          ? _value._vehicles
          : vehicles // ignore: cast_nullable_to_non_nullable
              as List<Vehicle>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$VehiclesStateImpl implements _VehiclesState {
  const _$VehiclesStateImpl(
      {this.loading = false,
      final List<Vehicle> vehicles = const [],
      this.errorMessage})
      : _vehicles = vehicles;

  @override
  @JsonKey()
  final bool loading;
  final List<Vehicle> _vehicles;
  @override
  @JsonKey()
  List<Vehicle> get vehicles {
    if (_vehicles is EqualUnmodifiableListView) return _vehicles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vehicles);
  }

  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'VehiclesState(loading: $loading, vehicles: $vehicles, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VehiclesStateImpl &&
            (identical(other.loading, loading) || other.loading == loading) &&
            const DeepCollectionEquality().equals(other._vehicles, _vehicles) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, loading,
      const DeepCollectionEquality().hash(_vehicles), errorMessage);

  /// Create a copy of VehiclesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VehiclesStateImplCopyWith<_$VehiclesStateImpl> get copyWith =>
      __$$VehiclesStateImplCopyWithImpl<_$VehiclesStateImpl>(this, _$identity);
}

abstract class _VehiclesState implements VehiclesState {
  const factory _VehiclesState(
      {final bool loading,
      final List<Vehicle> vehicles,
      final String? errorMessage}) = _$VehiclesStateImpl;

  @override
  bool get loading;
  @override
  List<Vehicle> get vehicles;
  @override
  String? get errorMessage;

  /// Create a copy of VehiclesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VehiclesStateImplCopyWith<_$VehiclesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
