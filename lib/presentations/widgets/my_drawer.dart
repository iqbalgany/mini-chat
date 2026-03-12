import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_chat/presentations/cubits/auth/auth_cubit.dart';
import 'package:mini_chat/routing/app_router.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,

      child: Column(
        children: [
          // logo
          DrawerHeader(
            child: Center(
              child: Icon(
                Icons.message,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),

          // home list tile
          ListTile(
            contentPadding: EdgeInsets.only(left: 25),
            title: Text('H O M E'),
            leading: Icon(Icons.home),
            onTap: () {
              context.pop();
            },
          ),

          // settings list tile
          ListTile(
            contentPadding: EdgeInsets.only(left: 25),
            title: Text('S E T T I N G S'),
            leading: Icon(Icons.settings),
            onTap: () {
              context.pop();
              context.push(AppRoutes.settings);
            },
          ),
          Spacer(),

          // logout list tile
          BlocListener<AuthCubit, AuthState>(
            listener: (context, authState) {
              if (authState.status == AuthStatus.unauthenticated) {
                context.go(AppRoutes.login);
              }
            },
            child: ListTile(
              contentPadding: EdgeInsets.only(left: 25),
              title: Text('L O G O U T'),
              leading: Icon(Icons.logout),
              onTap: () {
                context.read<AuthCubit>().logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
