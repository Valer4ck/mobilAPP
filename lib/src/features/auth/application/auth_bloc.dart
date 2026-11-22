import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/auth_user.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState.initial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event,
      Emitter<AuthState> emit,
      ) async {
    emit(const AuthState(status: AuthStatus.loading));
    await Future<void>.delayed(const Duration(milliseconds: 700));

    if (event.email.trim().isEmpty || event.password.length < 6) {
      emit(const AuthState(
        status: AuthStatus.failure,
        error: 'Проверьте email и пароль: минимум 6 символов',
      ));
      return;
    }

    emit(AuthState(
      status: AuthStatus.authenticated,
      user: AuthUser(
        name: event.email.split('@').first,
        email: event.email.trim(),
      ),
    ));
  }

  Future<void> _onRegisterSubmitted(
      RegisterSubmitted event,
      Emitter<AuthState> emit,
      ) async {
    emit(const AuthState(status: AuthStatus.loading));
    await Future<void>.delayed(const Duration(milliseconds: 700));

    if (event.name.trim().isEmpty) {
      emit(const AuthState(
        status: AuthStatus.failure,
        error: 'Введите ФИО',
      ));
      return;
    }
    if (event.password != event.confirmPassword) {
      emit(const AuthState(
        status: AuthStatus.failure,
        error: 'Пароли не совпадают',
      ));
      return;
    }
    if (event.password.length < 6) {
      emit(const AuthState(
        status: AuthStatus.failure,
        error: 'Пароль должен содержать минимум 6 символов',
      ));
      return;
    }

    emit(AuthState(
      status: AuthStatus.authenticated,
      user: AuthUser(name: event.name.trim(), email: event.email.trim()),
    ));
  }

  void _onLogoutRequested(
      LogoutRequested event,
      Emitter<AuthState> emit,
      ) {
    emit(const AuthState(status: AuthStatus.unauthenticated));
  }
}