import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/otp_screen.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/home/presentation/screens/home_shell.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/audio_party/presentation/screens/audio_room_screen.dart';
import '../../features/live/presentation/screens/live_screen.dart';
import '../../features/pk_battle/presentation/screens/pk_battle_screen.dart';
import '../../features/chat/presentation/screens/chat_list_screen.dart';
import '../../features/chat/presentation/screens/chat_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/admin/presentation/screens/admin_dashboard_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/login',
    redirect: (context, state) {
      final authStatus = ref.read(authProvider).status;
      final isAuthRoute = state.matchedLocation == '/login' ||
          state.matchedLocation == '/otp';

      if (authStatus == AuthStatus.unauthenticated && !isAuthRoute) {
        return '/login';
      }
      if (authStatus == AuthStatus.authenticated && isAuthRoute) {
        return '/home';
      }
      return null;
    },
    refreshListenable: _AuthListenable(ref),
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/otp',
        builder: (context, state) => OtpScreen(phone: state.extra as String? ?? ''),
      ),

      // Full-screen routes that sit above the bottom-nav shell.
      GoRoute(
        path: '/live/:roomId',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) =>
            LiveScreen(roomId: state.pathParameters['roomId']!),
      ),
      GoRoute(
        path: '/pk/:battleId',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) =>
            PkBattleScreen(battleId: state.pathParameters['battleId']!),
      ),
      GoRoute(
        path: '/chat/:threadId',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) =>
            ChatScreen(threadId: state.pathParameters['threadId']!),
      ),
      GoRoute(
        path: '/admin',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const AdminDashboardScreen(),
      ),

      // Bottom-nav tabs.
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            HomeShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/audio',
              builder: (context, state) => const AudioRoomScreen(roomId: 'lobby'),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/go-live',
              builder: (context, state) => const LiveScreen(roomId: 'new'),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/chats', builder: (context, state) => const ChatListScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
          ]),
        ],
      ),
    ],
  );
});

/// Bridges Riverpod's authProvider changes into GoRouter's refreshListenable
/// so `redirect` re-runs whenever auth status changes.
class _AuthListenable extends ChangeNotifier {
  _AuthListenable(this._ref) {
    _ref.listen(authProvider, (_, __) => notifyListeners());
  }

  final Ref _ref;
}
