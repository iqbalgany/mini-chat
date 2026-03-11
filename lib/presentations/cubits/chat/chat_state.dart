// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_cubit.dart';

enum ChatStatus { initial, loading, success, failure }

class ChatState extends Equatable {
  final List<Map<String, dynamic>>? users;
  final ChatStatus status;
  final String errorMessage;
  const ChatState({
    this.users = const [],
    this.status = ChatStatus.initial,
    this.errorMessage = '',
  });

  @override
  List<Object?> get props => [users, status, errorMessage];

  ChatState copyWith({
    List<Map<String, dynamic>>? users,
    ChatStatus? status,
    String? errorMessage,
  }) {
    return ChatState(
      users: users ?? this.users,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
