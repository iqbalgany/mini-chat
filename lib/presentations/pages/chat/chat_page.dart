import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;
  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.tertiary),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          receiverEmail,
          style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
        ),
      ),
    );
  }
}
