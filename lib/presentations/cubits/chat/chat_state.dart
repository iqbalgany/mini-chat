// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_cubit.dart';

enum ChatStatus { initial, loading, success, failure }

class ChatState extends Equatable {
  final List<MessageModel>? message;
  final ChatStatus status;
  final String errorMessage;
  const ChatState({
    this.status = ChatStatus.initial,
    this.errorMessage = '',
    this.message,
  });

  @override
  List<Object?> get props => [message, status, errorMessage];

  ChatState copyWith({
    List<MessageModel>? message,
    ChatStatus? status,
    String? errorMessage,
  }) {
    return ChatState(
      message: message ?? this.message,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
