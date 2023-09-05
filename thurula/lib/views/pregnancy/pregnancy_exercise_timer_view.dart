import 'dart:async';
import 'package:flutter/material.dart';
import 'package:thurula/views/pregnancy/pregnancy_exercise_recommendations_view.dart';

class ExerciseTimerView extends StatelessWidget {
  const ExerciseTimerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TimerPage(),
    );
  }
}

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final Duration _initialDuration = const Duration(seconds: 45);
  Duration _remainingDuration = const Duration(seconds: 45);
  bool _isRunning = false;
  bool _isPaused = false;

  void toggleTimer() {
    setState(() {
      if (!_isRunning) {
        _startTimer();
      } else {
        _isPaused = !_isPaused;
      }
    });
  }

  void _startTimer() {
    _isRunning = true;
    _isPaused = false;

    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!_isRunning) {
        timer.cancel();
      } else if (_isPaused) {
        // Do nothing, timer is paused
      } else if (_remainingDuration.inMilliseconds <= 0) {
        setState(() {
          _isRunning = false;
          _isPaused = false;
        });
        timer.cancel();
      } else {
        setState(() {
          _remainingDuration -= const Duration(milliseconds: 100);
        });
      }
    });
  }

  void resetTimer() {
    setState(() {
      _remainingDuration = _initialDuration;
      _isRunning = false;
      _isPaused = false;
    });
  }

  String formatDuration(Duration duration) {
    int minutes = duration.inMinutes;
    int seconds = (duration.inSeconds % 60);
    int milliseconds = (duration.inMilliseconds % 1000) ~/ 100;

    return '$minutes:${seconds.toString().padLeft(2, '0')}.$milliseconds';
  }

  void _showInstructions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
              'Diaphragmatic Breath with Pelvic Floor Activation',
              style: TextStyle(
                color: Color.fromARGB(255, 220, 104, 145),
                //   bold
                fontWeight: FontWeight.bold,
              )
          ),
          content: const SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Step 1: Stand with feet wide, knees soft, eyes closed and hands on belly.\n',
                  style: TextStyle(
                    //   hex color #878787
                    color: Color.fromARGB(255, 135, 135, 135),
                  ),
                ),
                Text(
                  'Step 2: Take deep breaths into the belly allowing it to expand and contract fully.\n',
                  style: TextStyle(
                    color: Color.fromARGB(255, 135, 135, 135),
                  ),
                ),
                Text(
                  'Step 3:  As you exhale, think of stopping the flow of urine, contracting vaginally, rectally, and feeling how the tailbone naturally flexes without adding any movement there.\n',
                  style: TextStyle(
                    color: Color.fromARGB(255, 135, 135, 135),
                  ),
                ),
                Text(
                  'Step 4:   As you exhale and contract the pelvic floor, add pulling the abdominal in and up as if you were riding an elevator from the basement to the top floor of a building.',
                  style: TextStyle(
                    color: Color.fromARGB(255, 135, 135, 135),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              //   text color pink
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 220, 104, 145),
              ),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
        // back button
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ExercisesView()));
          },
        ),
        title: const Text('Diaphragmatic Breath'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: _showInstructions,
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Text(
            //   'Diaphragmatic Breath',
            //   style: TextStyle(
            //       fontSize: 25,
            //       fontWeight: FontWeight.bold,
            //       color: Color.fromARGB(255, 220, 104, 145)
            //   ),
            // ),
            const SizedBox(height: 30),
            Stack(
              alignment: Alignment.center,
              children: [
                // title
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 300, // Adjust the width and height to change the size of the indicator
                      height: 300,
                      child: CircularProgressIndicator(
                        // in milliseconds
                        value: _remainingDuration.inMilliseconds / _initialDuration.inMilliseconds,
                        strokeWidth: 8,
                        backgroundColor: Colors.white,
                        valueColor: const AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 238, 198, 212),
                        ),
                      ),
                    ),
                    Text(
                      formatDuration(_remainingDuration),
                      style: const TextStyle(fontSize: 60),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: toggleTimer,
              // circular button
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(), backgroundColor: const Color.fromARGB(255, 220, 104, 145),
                padding: const EdgeInsets.all(24),
              ),
              // play icon
              child: Icon(_isRunning && !_isPaused ? Icons.pause : Icons.play_arrow),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: resetTimer,
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 220, 104, 145), backgroundColor: Colors.white, shape: const CircleBorder(),
                padding: const EdgeInsets.all(24),
              ),
              child: const Icon(Icons.replay),
            ),
          ],
        ),
      ),
    );
  }
}