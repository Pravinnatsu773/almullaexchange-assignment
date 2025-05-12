import 'package:al_mullah_asignment/constants/strings.dart';
import 'package:al_mullah_asignment/features/dashboard/cubit/task_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_task_page.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _TodoView();
  }
}

class _TodoView extends StatelessWidget {
  const _TodoView({super.key});

  String formattedDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat.yMMMd().add_jm();
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoaded) {
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return ListTile(
                  title: Text(task.description),
                  subtitle: Text(formattedDateTime(task.dateTime)),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          // title: Text(AppStrings.todoConfirmDeletionTitle.tr()),
                          content: Text(AppStrings.confirmDeletionMessage.tr()),
                          actions: [
                            TextButton(
                              onPressed: () {
                                context.read<TaskCubit>().removeTask(task);
                                Navigator.pop(context);
                              },
                              child: Text(AppStrings.ok.tr()),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(AppStrings.cancel.tr()),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
          return Center(child: Text(AppStrings.todoNoTasksAvailable.tr()));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
