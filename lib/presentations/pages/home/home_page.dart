import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_chat/presentations/cubits/chat/chat_cubit.dart';
import 'package:mini_chat/presentations/widgets/my_drawer.dart';
import 'package:mini_chat/presentations/widgets/user_tile.dart';

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
      ),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, chatState) {
          if (chatState.status == ChatStatus.failure) {
            return Center(child: Text(chatState.errorMessage));
          }

          if (chatState.status == ChatStatus.loading) {
            return Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<ChatCubit>().loadUsers();
            },
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: chatState.users?.length ?? 0,
              itemBuilder: (context, index) {
                final email = chatState.users![index]['email'];
                final id = chatState.users![index]['uid'];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: UserTile(
                    text: email,
                    onTap: () {
                      context.push('/chat/$email/$id');
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
