import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';
part 'auth_user.g.dart';

@freezed
class AuthUser with _$AuthUser {
  const factory AuthUser({
    required String email,
    @JsonKey(fromJson: _idFromJson, toJson: _idToJson) String? id,
  }) = _AuthUser;

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);
}

String? _idFromJson(Object? value) => value?.toString();

Object? _idToJson(String? value) => value;
