import 'package:al_mullah_asignment/constants/strings.dart';
import 'package:al_mullah_asignment/features/auth/cubit/auth_cubit.dart';
import 'package:al_mullah_asignment/features/dashboard/cubit/tab_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
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
                title: Text(AppStrings.changeLanguage.tr()),
                onTap: () async {
                  final currentLocale = context.locale;
                  final newLocale = currentLocale.languageCode == 'en'
                      ? const Locale('ar')
                      : const Locale('en');

                  await context.setLocale(newLocale);
                  Navigator.pop(context); // Close drawer
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: Text(AppStrings.logout.tr()),
                onTap: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text(AppStrings.logout.tr()),
                      content: Text(AppStrings.confirmLogoutMessage.tr()),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text(AppStrings.cancel.tr()),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text(AppStrings.ok.tr()),
                        ),
                      ],
                    ),
                  );

                  if (confirm ?? false) {
                    context.read<AuthCubit>().signOut(context);
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
