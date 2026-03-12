import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mini_chat/data/models/message_model.dart';
import 'package:mini_chat/data/remote_datasource/chat/chat_remote_datasource.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRemoteDatasource _datasource;
  StreamSubscription? _messageSubscription;
  ChatCubit(this._datasource) : super(const ChatState());

  void getMessages(String receiverID) {
    emit(state.copyWith(status: ChatStatus.loading));

    _messageSubscription?.cancel();

    final myID = FirebaseAuth.instance.currentUser!.uid;

    _messageSubscription = _datasource.getMessages(myID, receiverID).listen((
      snapshot,
    ) {
      final messages = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return MessageModel.fromMap(data);
      }).toList();

      emit(state.copyWith(status: ChatStatus.success, message: messages));
    });
  }

  Future<void> sendMessage(String receiverID, message) async {
    emit(state.copyWith(status: ChatStatus.loading));
    log('loading send messages');
    try {
      await _datasource.sendMessage(receiverID, message);
      log('success send message');
    } catch (e) {
      log('error send message: $e');
    }
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    return super.close();
  }
}
