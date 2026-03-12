// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

enum AuthStatus {
  initial,
  loading,
  success,
  authenticated,
  unauthenticated,
  failure,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final UserModel? user;
  final List<Map<String, dynamic>>? users;
  final String? errorMessage;
  const AuthState({
    this.status = AuthStatus.initial,
    this.errorMessage = '',
    this.user,
    this.users,
  });

  @override
  List<Object?> get props => [status, user, users, errorMessage];

  AuthState copyWith({
    AuthStatus? status,
    UserModel? user,
    List<Map<String, dynamic>>? users,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      users: users ?? this.users,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
