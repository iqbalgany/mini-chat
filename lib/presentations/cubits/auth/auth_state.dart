part of 'auth_cubit.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, failure }

class AuthState extends Equatable {
  final AuthStatus status;
  final UserModel? user;
  final String? errorMessage;
  const AuthState({
    this.status = AuthStatus.initial,
    this.errorMessage = '',
    this.user,
  });

  @override
  List<Object?> get props => [status, user, errorMessage];

  AuthState copyWith({
    AuthStatus? status,
    UserModel? user,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
