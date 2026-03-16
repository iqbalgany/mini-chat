import 'package:go_router/go_router.dart';
import 'package:mini_chat/data/remote_datasource/auth/auth_remote_datasource.dart';
import 'package:mini_chat/presentations/cubits/auth/auth_cubit.dart';
import 'package:mini_chat/presentations/pages/auth/login_page.dart';
import 'package:mini_chat/presentations/pages/auth/register_page.dart';
import 'package:mini_chat/presentations/pages/chat/chat_page.dart';
import 'package:mini_chat/presentations/pages/home/home_page.dart';
import 'package:mini_chat/presentations/pages/settings/settings_page.dart';
import 'package:mini_chat/routing/go_router_refresh_stream.dart';

class AppRoutes {
  static final authCubit = AuthCubit(AuthRemoteDatasource());

  static const home = '/';
  static const login = '/login';
  static const register = '/register';
  static const settings = '/settings';
  static const chat = '/chat/:receiverEmail/:receiverID';

  static final router = GoRouter(
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
    initialLocation: home,

    redirect: (context, state) {
      final authState = authCubit.state;
      final bool isLoggedIn = authState.status == AuthStatus.authenticated;

      final bool isAuthPage =
          state.matchedLocation == login || state.matchedLocation == register;

      if (!isLoggedIn && !isAuthPage) return login;
      if (isLoggedIn && isAuthPage) return home;
      return null;
    },

    routes: [
      GoRoute(path: home, builder: (context, state) => HomePage()),
      GoRoute(path: login, builder: (context, state) => LoginPage()),
      GoRoute(path: register, builder: (context, state) => RegisterPage()),
      GoRoute(path: settings, builder: (context, state) => SettingsPage()),
      GoRoute(
        path: chat,
        builder: (context, state) {
          final email = state.pathParameters['receiverEmail'] ?? 'No Email';
          final id = state.pathParameters['receiverID'] ?? 'No Email';
          final firstName = state.uri.queryParameters['firstName'] ?? '';
          final lastName = state.uri.queryParameters['lastName'] ?? '';
          return ChatPage(
            receiverEmail: email,
            receiverID: id,
            firstName: firstName,
            lastName: lastName,
          );
        },
      ),
    ],
  );
}
