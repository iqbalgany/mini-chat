import 'package:flutter/material.dart';

class MyChatBubble extends StatelessWidget {
  final String message;
  final bool currentUser;
  const MyChatBubble({
    super.key,
    required this.message,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: currentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(15),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.7,
        ),
        decoration: BoxDecoration(
          color: currentUser
              ? Theme.of(context).colorScheme.secondary
              : Colors.grey.shade600,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
            topLeft: Radius.circular(currentUser ? 15 : 0),
            topRight: Radius.circular(currentUser ? 0 : 15),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: currentUser
                ? Theme.of(context).colorScheme.inversePrimary
                : Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ),
    );
  }
}
