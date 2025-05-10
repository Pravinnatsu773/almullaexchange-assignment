import 'package:al_mullah_asignment/features/dashboard/cubit/tab_cubit.dart';
import 'package:al_mullah_asignment/features/dashboard/cubit/task_cubit.dart';
import 'package:al_mullah_asignment/firebase_options.dart';

import 'core/app_router.dart';
import 'features/auth/cubit/auth_cubit.dart';
import 'features/language/cubit/language_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();

  final authCubit = AuthCubit();
  AppRouter.setupRouter(authCubit);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      saveLocale: true,
      child: BlocProvider.value(
        value: authCubit,
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => LanguageCubit()),
        BlocProvider(
          create: (_) => TaskCubit(),
        ),
        BlocProvider(
          create: (_) => TabCubit(),
        )
      ],
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp.router(
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
          );
        },
      ),
    );
  }
}
