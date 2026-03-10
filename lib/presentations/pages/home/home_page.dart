import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_chat/presentations/cubits/auth/auth_cubit.dart';
import 'package:mini_chat/presentations/pages/auth/login_page.dart';
import 'package:mini_chat/presentations/widgets/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Home', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          BlocListener<AuthCubit, AuthState>(
            listener: (context, authState) {
              if (authState.status == AuthStatus.unauthenticated) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false,
                );
              }

              if (authState.status == AuthStatus.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(milliseconds: 1500),
                    content: Text(
                      authState.errorMessage ?? 'Failed to Sign Out',
                    ),
                  ),
                );
              }
            },
            child: IconButton(
              onPressed: () {
                context.read<AuthCubit>().logout();
              },
              icon: Icon(Icons.logout),
            ),
          ),
        ],
      ),
    );
  }
}
