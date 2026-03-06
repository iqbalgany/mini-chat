import 'package:flutter/material.dart';
import 'package:mini_chat/presentations/widgets/my_button.dart';
import 'package:mini_chat/presentations/widgets/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmationPasswordController = TextEditingController();
  RegisterPage({super.key});

  void register() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),

            SizedBox(height: 50),

            // welcome back message
            Text(
              'Let\'s create account for you',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),

            SizedBox(height: 25),

            // email textfield
            MyTextfield(hintText: 'Email', controller: emailController),

            SizedBox(height: 10),

            // password textfield
            MyTextfield(
              hintText: 'Password',
              controller: passwordController,
              obscureText: true,
            ),
            SizedBox(height: 10),

            // confirmation password textfield
            MyTextfield(
              hintText: 'Confirmation Password',
              controller: passwordController,
              obscureText: true,
            ),

            SizedBox(height: 25),

            // register button
            MyButton(text: 'Register', onTap: register),

            SizedBox(height: 25),

            // register now
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Already have an account?',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  TextSpan(
                    text: ' Login now',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
