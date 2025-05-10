part of 'stop_watch_cubit.dart';

@immutable
sealed class StopwatchState {}

class StopwatchInitial extends StopwatchState {}

class StopwatchRunning extends StopwatchState {
  final int seconds;

  StopwatchRunning({required this.seconds});
}

class StopwatchPaused extends StopwatchState {
  final int seconds;

  StopwatchPaused({required this.seconds});
}

class StopwatchReset extends StopwatchState {}
