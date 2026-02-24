import 'package:axle_tracking_cms/features/auth/domain/entities/auth_session.dart';
import 'package:axle_tracking_cms/features/auth/domain/entities/auth_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_response_dto.freezed.dart';
part 'auth_response_dto.g.dart';

@freezed
class AuthResponseDto with _$AuthResponseDto {
  const factory AuthResponseDto({
    required String token,
    required AuthUser user,
  }) = _AuthResponseDto;

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseDtoFromJson(json);
}

extension AuthResponseDtoX on AuthResponseDto {
  AuthSession toDomain() => AuthSession(token: token, user: user);
}
