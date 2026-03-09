import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_chat/presentations/cubits/auth/auth_cubit.dart';
import 'package:mini_chat/presentations/widgets/my_button.dart';
import 'package:mini_chat/presentations/widgets/my_textfield.dart';
import 'package:mini_chat/routing/app_router.dart';

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
              controller: confirmationPasswordController,
              obscureText: true,
            ),

            SizedBox(height: 25),

            // register button
            BlocListener<AuthCubit, AuthState>(
              listener: (context, authState) {
                if (authState.status == AuthStatus.failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).colorScheme.error,
                      content: Text(authState.errorMessage ?? ''),
                    ),
                  );
                }
              },
              child: MyButton(
                text: 'Register',
                onTap: () {
                  if (passwordController.text ==
                      confirmationPasswordController.text) {
                    context.read<AuthCubit>().signup(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Theme.of(context).colorScheme.error,
                        content: Text('Password don\'t match'),
                      ),
                    );
                  }
                },
              ),
            ),

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
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go(AppRoutes.login);
                        }
                      },
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
