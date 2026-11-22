import 'package:equatable/equatable.dart';
import '../domain/auth_user.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, failure }

class AuthState extends Equatable {
  final AuthStatus status;
  final AuthUser? user;
  final String? error;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.error,
  });

  const AuthState.initial()
      : status = AuthStatus.initial,
        user = null,
        error = null;

  @override
  List<Object?> get props => [status, user, error];
}