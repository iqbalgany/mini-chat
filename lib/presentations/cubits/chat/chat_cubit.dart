import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mini_chat/data/remote_datasource/chat/chat_remote_datasource.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRemoteDatasource _datasource;
  ChatCubit(this._datasource) : super(const ChatState()) {
    loadUsers();
  }

  void loadUsers() {
    emit(state.copyWith(status: ChatStatus.loading));
    log('Loading load user');

    _datasource.getUserStream().listen(
      (users) {
        emit(state.copyWith(status: ChatStatus.success, users: users));
        log('Success load user');
      },
      onError: (error) {
        emit(
          state.copyWith(
            status: ChatStatus.failure,
            errorMessage: error.toString(),
          ),
        );
        log('Error load user: $error');
      },
    );
  }
}
