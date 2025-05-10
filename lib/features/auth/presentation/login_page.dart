import 'package:al_mullah_asignment/features/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.login),
          label: Text("sign_in_with_google".tr()),
          onPressed: () {
            context.read<AuthCubit>().signInWithGoogle();
          },
        ),
      ),
    );
  }
}
