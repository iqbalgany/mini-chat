import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_chat/presentations/cubits/auth/auth_cubit.dart';
import 'package:mini_chat/presentations/widgets/my_button.dart';
import 'package:mini_chat/presentations/widgets/my_textfield.dart';
import 'package:mini_chat/routing/app_router.dart';

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                  'Welocome back, you\'ve have been miised',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),

                SizedBox(height: 25),

                // email textfield
                MyTextFormField(
                  hintText: 'Email',
                  isPassword: false,
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'The email is empty';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 10),

                // password textfield
                MyTextFormField(
                  isPassword: true,
                  hintText: 'Password',
                  controller: passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'minimum 6-character password';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 25),

                // login button
                MyButton(
                  text: 'Login',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthCubit>().login(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );
                    }
                  },
                ),

                SizedBox(height: 25),

                // register now
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Not a member?',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      TextSpan(
                        text: ' Register now',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.push(AppRoutes.register);
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
        ),
      ),
    );
  }
}
