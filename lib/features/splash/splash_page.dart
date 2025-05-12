import 'package:al_mullah_asignment/features/auth/cubit/auth_cubit.dart';
import 'package:al_mullah_asignment/features/auth/presentation/login_page.dart';
import 'package:al_mullah_asignment/features/dashboard/dash_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => DashboardPage()));
        } else if (state is AuthUnauthenticated) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => LoginPage()));
        }
      },
      child: const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
