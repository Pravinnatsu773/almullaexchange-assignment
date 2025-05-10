part of 'task_cubit.dart';

class Task extends Equatable {
  final String description;
  final DateTime dateTime;

  Task(this.description, this.dateTime);

  @override
  List<Object?> get props => [description, dateTime];
}

abstract class TaskState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  TaskLoaded(this.tasks);

  @override
  List<Object?> get props => [tasks];
}
