import 'package:al_mullah_asignment/core/go_router_refresh_notifier.dart';
import 'package:al_mullah_asignment/features/auth/presentation/login_page.dart';
import 'package:al_mullah_asignment/features/dashboard/dash_board.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/cubit/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static late final GoRouter router;

  static void setupRouter(AuthCubit authCubit) {
    router = GoRouter(
      initialLocation: '/login',
      refreshListenable: GoRouterRefreshNotifier(authCubit),
      redirect: (context, state) {
        final authState = authCubit.state;

        if (authState is AuthLoading) return null;

        final isLoggedIn = authState is AuthAuthenticated;
        final isLoggingIn = state.fullPath == '/login';

        if (!isLoggedIn && !isLoggingIn) return '/login';
        if (isLoggedIn && isLoggingIn) return '/dashboard';

        return null;
      },
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const DashboardPage(),
        ),
      ],
    );
  }
}