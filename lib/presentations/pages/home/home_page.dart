import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_chat/presentations/cubits/auth/auth_cubit.dart';
import 'package:mini_chat/presentations/widgets/my_drawer.dart';
import 'package:mini_chat/presentations/widgets/user_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          if (authState.status == AuthStatus.failure) {
            return Center(child: Text(authState.errorMessage ?? 'Error'));
          }

          if (authState.status == AuthStatus.loading) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: authState.users?.length ?? 0,
            itemBuilder: (context, index) {
              final userMap = authState.users![index];
              final email = userMap['email'];
              final id = userMap['uid'];
              final firstName = userMap['firstName'];
              final lastName = userMap['lastName'];
              final fullName = '$firstName $lastName'.trim();

              if (email == currentUser?.email) {
                return SizedBox.shrink();
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: UserTile(
                  text: fullName.isNotEmpty ? fullName : email,
                  onTap: () {
                    context.push(
                      '/chat/$email/$id?firstName=$firstName&lastName=$lastName',
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
