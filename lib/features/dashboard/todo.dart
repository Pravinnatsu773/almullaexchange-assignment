import 'package:al_mullah_asignment/features/dashboard/add_task_page.dart';
import 'package:al_mullah_asignment/features/dashboard/cubit/task_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _TodoView();
  }
}

class _TodoView extends StatelessWidget {
  const _TodoView({super.key});

  String formattedDateTime(dateTime) {
    final DateFormat formatter = DateFormat.yMMMd().add_jm();
    return formatter.format(dateTime); // Returns a human-readable format
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
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Show confirmation dialog before deleting
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Confirm Deletion'),
                            content: Text(
                                'Are you sure you want to delete this task?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  context.read<TaskCubit>().removeTask(task);
                                  Navigator.pop(context); // Close dialog
                                },
                                child: Text('Yes'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('No'),
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
            return Center(child: Text('No tasks available.'));
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final newTask = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTaskPage()),
            );
          },
          child: Icon(Icons.add),
        ));
  }
}
