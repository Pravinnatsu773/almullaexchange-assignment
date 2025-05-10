import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:async';

part 'stop_watch_state.dart';

class StopwatchCubit extends Cubit<StopwatchState> {
  StopwatchCubit() : super(StopwatchInitial());

  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;

  void startStopwatch() {
    if (_isRunning) return; // Don't start if it's already running
    _isRunning = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds++;
      emit(StopwatchRunning(seconds: _seconds));
    });
  }

  void pauseStopwatch() {
    if (!_isRunning) return;
    _isRunning = false;
    _timer?.cancel();
    emit(StopwatchPaused(seconds: _seconds));
  }

  void resetStopwatch() {
    _isRunning = false;
    _seconds = 0;
    _timer?.cancel();
    emit(StopwatchReset());
  }
}
