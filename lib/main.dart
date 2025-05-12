import 'package:al_mullah_asignment/features/auth/presentation/login_page.dart';
import 'package:al_mullah_asignment/features/dashboard/cubit/tab_cubit.dart';
import 'package:al_mullah_asignment/features/dashboard/cubit/task_cubit.dart';
import 'package:al_mullah_asignment/features/dashboard/dash_board.dart';
import 'package:al_mullah_asignment/features/splash/splash_page.dart';
import 'package:al_mullah_asignment/firebase_options.dart';

import 'features/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      saveLocale: true,
      child: MyApp(),
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
          BlocProvider(
            create: (_) => TaskCubit(),
          ),
          BlocProvider(
            create: (_) => TabCubit(),
          )
        ],
        child: MaterialApp(
          home: SplashPage(),
          debugShowCheckedModeBanner: false,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
        ));
  }
}
