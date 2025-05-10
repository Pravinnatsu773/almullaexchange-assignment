import 'package:al_mullah_asignment/features/auth/cubit/auth_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text("Change Language"),
                onTap: () async {
                  final currentLocale = context.locale;
                  final newLocale = currentLocale.languageCode == 'en'
                      ? const Locale('ar')
                      : const Locale('en');
                  await context.setLocale(newLocale);
                  context.pop(); // Close drawer
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
                onTap: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Logout"),
                      content: const Text("Are you sure you want to logout?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );

                  if (confirm ?? false) {
                    context.read<AuthCubit>().signOut();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
