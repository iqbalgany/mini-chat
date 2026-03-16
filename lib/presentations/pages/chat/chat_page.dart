// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_chat/presentations/cubits/chat/chat_cubit.dart';
import 'package:mini_chat/presentations/widgets/my_chat_bubble.dart';
import 'package:mini_chat/presentations/widgets/my_textfield.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;
  final String firstName;
  final String lastName;
  const ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
    required this.firstName,
    required this.lastName,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().getMessages(widget.receiverID);
  }

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final myUID = FirebaseAuth.instance.currentUser?.uid ?? '';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          widget.firstName.isNotEmpty
              ? '${widget.firstName} ${widget.lastName}'
              : widget.receiverEmail,
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
      ),
      body: Column(
        children: [
          // display all messages
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, chatState) {
                if (chatState.status == ChatStatus.failure) {
                  return Center(child: Text(chatState.errorMessage));
                }

                if (chatState.status == ChatStatus.loading) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  itemCount: chatState.message?.length ?? 0,
                  itemBuilder: (context, index) {
                    final user = chatState.message![index];
                    final isCurrentUser = user.senderID == myUID;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: isCurrentUser
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isCurrentUser) ...[
                            CircleAvatar(
                              radius: 25,
                              child: Icon(Icons.person, size: 30),
                            ),
                          ],
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: MyChatBubble(
                              message: user.message,
                              currentUser: isCurrentUser,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // user input
          MyTextFormField(
            isPassword: false,
            hintText: 'Type a message',
            controller: _messageController,
            obscureText: false,
            suffixIcon: IconButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.secondary,
                ),
                iconColor: WidgetStatePropertyAll(Colors.black),
              ),
              iconSize: 30,
              onPressed: () {
                if (_messageController.text.isNotEmpty) {
                  context.read<ChatCubit>().sendMessage(
                    widget.receiverID,
                    _messageController.text.trim(),
                  );
                  _messageController.clear();
                }
              },
              icon: Icon(Icons.send),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
