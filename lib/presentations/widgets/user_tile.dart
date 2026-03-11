import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const UserTile({super.key, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // icon
            Icon(Icons.person),
            SizedBox(width: 10),

            // user name
            Text(text),
          ],
        ),
      ),
    );
  }
}
