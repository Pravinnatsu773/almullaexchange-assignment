import 'package:al_mullah_asignment/constants/strings.dart';
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
    return BlocBuilder<TabCubit, TabState>(
      builder: (context, state) {
        // List of pages to display based on the selected tab
        final List<Widget> pages = [
          EncryptionPage(),
          TodoPage(),
          StopwatchPage(),
        ];

        final List<String> tabTitle = [
          AppStrings.encryption,
          AppStrings.toDo,
          AppStrings.stopwatch,
        ];

        return Scaffold(
          drawer: const AppDrawer(),
          appBar: AppBar(title: Text(tabTitle[state.selectedIndex].tr())),
          body: pages[state.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.selectedIndex,
            onTap: (index) {
              context.read<TabCubit>().changeTab(index); // Change tab index
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.lock),
                label: tabTitle[0],
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_circle),
                label: tabTitle[1],
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.timer),
                label: tabTitle[2],
              ),
            ],
          ),
        );
      },
    );
  }
}
