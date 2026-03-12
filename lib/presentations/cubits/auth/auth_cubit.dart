import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:mini_chat/data/models/user_model.dart';
import 'package:mini_chat/data/remote_datasource/auth/auth_remote_datasource.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRemoteDatasource _auth;

  late StreamSubscription<fb.User?> _authSubsription;

  AuthCubit(this._auth) : super(const AuthState()) {
    _authSubsription = _auth.authStateChange.listen((fbUser) {
      if (fbUser != null) {
        final myUser = UserModel(uid: fbUser.uid, email: fbUser.email);
        emit(state.copyWith(status: AuthStatus.authenticated, user: myUser));
      } else {
        emit(state.copyWith(status: AuthStatus.unauthenticated, user: null));
      }
    });
    loadUsers();
  }

  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: AuthStatus.loading));
    log('Loading');
    try {
      await _auth.signInWithEmailPassword(email, password);
      log('Success');
    } catch (e) {
      log("DEBUG ERROR: $e");
      emit(
        state.copyWith(errorMessage: e.toString(), status: AuthStatus.failure),
      );
    }
  }

  Future<void> signup(String email, String password) async {
    emit(state.copyWith(status: AuthStatus.loading));
    log('Loading');
    try {
      await _auth.signUpWithEmailPassword(email, password);
      log('Success');
    } catch (e) {
      log("DEBUG ERROR: $e");
      emit(
        state.copyWith(errorMessage: e.toString(), status: AuthStatus.failure),
      );
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<void> loadUsers() async {
    emit(state.copyWith(status: AuthStatus.loading));
    log('Loading load user');

    _auth.getUserStream().listen(
      (users) {
        emit(state.copyWith(status: AuthStatus.authenticated, users: users));
        log('Success load user');
      },
      onError: (error) {
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            errorMessage: error.toString(),
          ),
        );
        log('Error load user: $error');
      },
    );
  }

  @override
  Future<void> close() {
    _authSubsription.cancel();
    return super.close();
  }
}
