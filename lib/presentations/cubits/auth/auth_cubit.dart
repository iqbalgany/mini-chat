import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mini_chat/data/remote_datasource/auth/auth_remote_datasource.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRemoteDatasource _auth;
  late StreamSubscription<User?> _authSubsription;
  AuthCubit(this._auth) : super(const AuthState()) {
    _authSubsription = _auth.authStateChange.listen((user) {
      if (user != null) {
        emit(state.copyWith(status: AuthStatus.authenticated, user: user));
      } else {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      }
    });
  }

  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _auth.signInWithEmailPassword(email, password);
    } catch (e) {
      emit(
        state.copyWith(errorMessage: e.toString(), status: AuthStatus.failure),
      );
    }
  }

  Future<void> signup(String email, String password) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _auth.signUpWithEmailPassword(email, password);
    } catch (e) {
      emit(
        state.copyWith(errorMessage: e.toString(), status: AuthStatus.failure),
      );
    }
  }

  Future<void> logout() async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _auth.signOut();
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: 'Failed to logout',
          status: AuthStatus.failure,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _authSubsription.cancel();
    return super.close();
  }
}
