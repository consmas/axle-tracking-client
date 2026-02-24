import 'package:axle_tracking_cms/core/network/app_exception.dart';
import 'package:axle_tracking_cms/core/services/session_invalidator.dart';
import 'package:axle_tracking_cms/features/auth/domain/entities/auth_user.dart';
import 'package:axle_tracking_cms/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_controller.freezed.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated }

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStatus.initial) AuthStatus status,
    AuthUser? user,
    String? errorMessage,
  }) = _AuthState;
}

class AuthController extends StateNotifier<AuthState> {
  AuthController(
    this._repository,
    this._sessionInvalidator,
  ) : super(const AuthState()) {
    _sessionInvalidator.addListener(_onSessionInvalidated);
    initialize();
  }

  final AuthRepository _repository;
  final SessionInvalidator _sessionInvalidator;

  bool get isAuthenticated => state.status == AuthStatus.authenticated;

  Future<void> initialize() async {
    final token = await _repository.getSavedToken();
    if (token != null && token.isNotEmpty) {
      try {
        await _repository.initializeCmsSession();
      } on AppException catch (error) {
        if (error.isUnauthorized) {
          await _repository.logout();
          state = const AuthState(status: AuthStatus.unauthenticated);
          return;
        }
      }
      state =
          state.copyWith(status: AuthStatus.authenticated, errorMessage: null);
      return;
    }
    state = state.copyWith(status: AuthStatus.unauthenticated);
  }

  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);
    try {
      final session = await _repository.login(email: email, password: password);
      state = state.copyWith(
        status: AuthStatus.authenticated,
        user: session.user,
        errorMessage: null,
      );
    } on AppException catch (error) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: error.userMessage,
      );
    }
  }

  Future<void> register(
      {required String email, required String password}) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);
    try {
      final session =
          await _repository.register(email: email, password: password);
      state = state.copyWith(
        status: AuthStatus.authenticated,
        user: session.user,
        errorMessage: null,
      );
    } on AppException catch (error) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: error.userMessage,
      );
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }

  Future<void> forceLogout() async {
    await _repository.logout();
    state = state.copyWith(
      status: AuthStatus.unauthenticated,
      user: null,
      errorMessage: 'Session expired. Please login again.',
    );
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  void _onSessionInvalidated() {
    forceLogout();
  }

  @override
  void dispose() {
    _sessionInvalidator.removeListener(_onSessionInvalidated);
    super.dispose();
  }
}
