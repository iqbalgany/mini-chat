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
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmationPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  RegisterPage({super.key});

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
                  'Let\'s create account for you',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),

                SizedBox(height: 25),

                // email textfield
                MyTextFormField(
                  hintText: 'Email',
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'The email is empty';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),

                // first name textfield
                MyTextFormField(
                  hintText: 'First Name',
                  controller: firstNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'The first name is empty';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),

                // last name textfield
                MyTextFormField(
                  hintText: 'Last Name',
                  controller: lastNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'The last name is empty';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 10),

                // password textfield
                MyTextFormField(
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
                SizedBox(height: 10),

                // confirmation password textfield
                MyTextFormField(
                  hintText: 'Confirmation Password',
                  controller: confirmationPasswordController,
                  obscureText: true,
                  validator: (value) {
                    if (value != passwordController.text) {
                      return 'password does not match';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 25),

                // register button
                MyButton(
                  text: 'Register',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthCubit>().signup(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                        firstNameController.text.trim(),
                        lastNameController.text.trim(),
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
        ),
      ),
    );
  }
}
