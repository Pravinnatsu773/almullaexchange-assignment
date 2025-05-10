import 'package:al_mullah_asignment/features/dashboard/app_drawer.dart';
import 'package:al_mullah_asignment/features/dashboard/cubit/tab_cubit.dart';
import 'package:al_mullah_asignment/features/dashboard/encryption_page.dart';
import 'package:al_mullah_asignment/features/dashboard/stop_watch.dart';
import 'package:al_mullah_asignment/features/dashboard/todo.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: Text('welcome'.tr())),
      body: BlocBuilder<TabCubit, TabState>(
        builder: (context, state) {
          // List of pages to display based on the selected tab
          final List<Widget> pages = [
            const EncryptionPage(),
            const TodoPage(),
            StopwatchPage(),
          ];

          // Display the page for the selected tab index
          return pages[state.selectedIndex];
        },
      ),
      bottomNavigationBar: BlocBuilder<TabCubit, TabState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.selectedIndex,
            onTap: (index) {
              context.read<TabCubit>().changeTab(index); // Change tab index
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.lock),
                label: 'Encryption',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_circle),
                label: 'To-Do',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.timer),
                label: 'Stopwatch',
              ),
            ],
          );
        },
      ),
    );
  }
}
