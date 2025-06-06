import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());


  void addTask(String taskDescription, DateTime taskDateTime) {
    final task = Task(taskDescription, taskDateTime);
    if (state is TaskLoaded) {
      final updatedTasks = List<Task>.from((state as TaskLoaded).tasks)
        ..add(task);
      emit(TaskLoaded(updatedTasks));
    } else {
      emit(TaskLoaded([task]));
    }
  }

 
  void removeTask(Task task) {
    if (state is TaskLoaded) {
      final updatedTasks = List<Task>.from((state as TaskLoaded).tasks)
        ..remove(task);
      emit(TaskLoaded(updatedTasks));
    }
  }
}
