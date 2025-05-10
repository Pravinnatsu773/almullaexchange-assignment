import 'package:al_mullah_asignment/features/dashboard/cubit/stop_watch_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StopwatchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch'),
      ),
      body: BlocProvider(
        create: (_) => StopwatchCubit(),
        child: StopwatchView(),
      ),
    );
  }
}

class StopwatchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StopwatchCubit, StopwatchState>(
      builder: (context, state) {
        String timerText = "00:00:00";

        if (state is StopwatchRunning || state is StopwatchPaused) {
          int seconds = (state is StopwatchRunning)
              ? state.seconds
              : (state is StopwatchPaused)
                  ? state.seconds
                  : 0;

          int hours = (seconds ~/ 3600).toInt(); // Calculate hours
          int minutes = (seconds ~/ 60) % 60; // Calculate minutes
          int remainingSeconds = seconds % 60; // Calculate seconds

          timerText =
              '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Stopwatch Timer inside a large circle
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.width * 0.75,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: Colors.black,
                    )),
                child: Center(
                  child: Text(
                    timerText,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),

              // Controls with icons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.play_arrow, size: 40),
                    onPressed: () {
                      context.read<StopwatchCubit>().startStopwatch();
                    },
                  ),
                  SizedBox(width: 30),
                  IconButton(
                    icon: Icon(Icons.pause, size: 40),
                    onPressed: () {
                      context.read<StopwatchCubit>().pauseStopwatch();
                    },
                  ),
                  SizedBox(width: 30),
                  IconButton(
                    icon: Icon(Icons.stop, size: 40),
                    onPressed: () {
                      context.read<StopwatchCubit>().resetStopwatch();
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
