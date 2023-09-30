import 'dart:async';
import 'package:flutter/material.dart';
import 'package:thurula/services/local_service.dart';
import 'package:thurula/services/user_exercise_service.dart';
import 'package:thurula/views/pregnancy/pregnancy_exercises/pregnancy_exercise_recommendations_view.dart';

import '../../../constants/exercises.dart';
import '../../../models/user_exercise_model.dart';


DateTime today = DateTime.now();
// change today to 11 59 pm
DateTime todayEnd = DateTime(today.year, today.month, today.day, 23, 59, 59);
DateTime todayStart = DateTime(
    today.year, today.month, today.day - 1, 23, 59, 59);

late Future<String> userId;
late List<UserExercise> userExercises;

// get ID of user exercise for that day
Future<String?> getUserExerciseID() async {
  // get user
  String userId = await LocalService.getCurrentUserId();
  // get user exercises
  userExercises =
      await UserExerciseService.getUserExercises(userId, todayStart, todayEnd);

  // if userExercises is empty
  if (userExercises.isEmpty) {
    // create new user exercise
    UserExercise newUserExercise = UserExercise(
      userId: userId,
      minutesExercised: 1,
      date: today,
    );
    // add user exercise
    var nux = await UserExerciseService.createUserExercise(newUserExercise);
    return nux.id;
  }else{
    // return first exercise ID
    return userExercises[0].id;
  }
}


class ExerciseTimerView extends StatelessWidget {
  final String exercise;

  const ExerciseTimerView({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TimerPage(exercise: exercise),
    );
  }
}

class TimerPage extends StatefulWidget {
  final String exercise;

  const TimerPage({super.key, required this.exercise});

  @override
  _TimerPageState createState() => _TimerPageState(exercise);
}

class _TimerPageState extends State<TimerPage> {
  final String exercise;

  _TimerPageState(this.exercise);

  // final Duration _initialDuration = const Duration(seconds: 45);
  // Duration _remainingDuration = const Duration(seconds: 45);
  Duration _elapsedDuration = Duration.zero;
  bool _isRunning = false;
  bool _isPaused = false;
  late Timer _timer;

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
        // } else if (_remainingDuration.inMilliseconds <= 0) {
        //   setState(() {
        //     _isRunning = false;
        //     _isPaused = false;
        //   });
        //   timer.cancel();
      } else {
        setState(() {
          // _remainingDuration -= const Duration(milliseconds: 100);
          _elapsedDuration += const Duration(milliseconds: 100);
        });
      }
    });
  }

  void resetTimer() {
    setState(() {
      // _remainingDuration = _initialDuration;
      _elapsedDuration = Duration.zero;
      _isRunning = false;
      _isPaused = false;
    });
    _timer.cancel();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _showInstructions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              _getExerciseName(exercise.split(',')[0], exercise.split(',')[1]),
              style: const TextStyle(
                color: Color.fromARGB(255, 220, 104, 145),
                fontWeight: FontWeight.bold,
              )
            //     padding: const EdgeInsets.only(bottom: 10),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                // sized box
                const SizedBox(height: 15),
                // get exercise steps
                for (var i = 0;
                i <
                    _getExerciseDesc(
                        exercise.split(',')[0], exercise.split(',')[1])
                        .length;
                i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        // circled number
                        Container(
                          width: 25,
                          height: 25,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 88, 119, 161),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              (i + 1).toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // text
                        Expanded(
                          child: Text(
                            _getExerciseDesc(exercise.split(',')[0],
                                exercise.split(',')[1])[i],
                            style: const TextStyle(
                              color: Color.fromARGB(255, 80, 78, 78),
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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
    // store trimester in variable
    String trimester = exercise.split(', ')[0];
    // store index in variable
    String index = exercise.split(', ')[1];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
        // back button
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ExercisesView()));
          },
        ),
        title: Text(
            _getExerciseName(exercise.split(',')[0], exercise.split(',')[1])),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: _showInstructions,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // add image here
          Image.asset(
            _getExerciseImage(trimester, index),
            width: 500,
            height: 450,
            //   crop
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 50),
          // timer
          Text(
            formatDuration(_elapsedDuration),
            style: const TextStyle(fontSize: 50),
          ),
          const SizedBox(height: 15),
          // play pause buttons in a row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // play button
              ElevatedButton(
                onPressed: resetTimer,
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 220, 104, 145),
                  backgroundColor: Colors.white,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(15),
                ),
                child: const Icon(Icons.replay),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: toggleTimer,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: const Color.fromARGB(255, 220, 104, 145),
                  padding: const EdgeInsets.all(25),
                ),
                child: Icon(
                    _isRunning && !_isPaused ? Icons.pause : Icons.play_arrow),
              ),
              const SizedBox(width: 10),
              // next button
              ElevatedButton(
                  onPressed: () async {
                    // get time from timer
                    String time = formatDuration(_elapsedDuration);

                    // get currentDuration
                    int currentDuration = await LocalService.getDailyExerciseDuration();
                    if (currentDuration == 0) {
                      currentDuration += int.parse(time.split(':')[0]);
                    }

                    LocalService.setDailyExerciseDuration(currentDuration);
                    if (int.parse(index) < 5) {
                      Navigator.push(
                          context!,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ExerciseTimerView(
                                      exercise:
                                      '$trimester, ${int.parse(index) + 1}')));
                    } else {
                      // getUserExerciseID
                      getUserExerciseID().then((value) async =>
                          UserExerciseService.patchUserExercise(
                              value!, "minutesExercised",
                              await LocalService.getDailyExerciseDuration()));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExercisesView()));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 88, 119, 161),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Icon(Icons.done)),
            ],
          ),
        ],
      ),
    );
  }
}

// function to return the exercise name
String _getExerciseName(String trimester, String index) {
  switch (trimester) {
    case '1':
      return exerciseNamesT1[int.parse(index) - 1];
    case '2':
      return exerciseNamesT2[int.parse(index) - 1];
    case '3':
      return exerciseNamesT3[int.parse(index) - 1];
    default:
      return "Default";
  }
}

// function to return the exercise description
List<String> _getExerciseDesc(String trimester, String index) {
  switch (trimester) {
    case '1':
      return exerciseStepsT1[int.parse(index) - 1];
    case '2':
      return exerciseStepsT2[int.parse(index) - 1];
    case '3':
      return exerciseStepsT3[int.parse(index) - 1];
    default:
      return ["Default"];
  }
}

// function to return the exercise image name
String _getExerciseImage(String trimester, String index) {
  switch (trimester) {
    case '1':
      return "assets/images/exercises/firstm$index.png";
    case '2':
      return "assets/images/exercises/secondm$index.png";
    case '3':
      return "assets/images/exercises/thirdm$index.png";
    default:
      return "Default";
  }
}

String formatDuration(Duration duration) {
  int minutes = duration.inMinutes;
  int seconds = (duration.inSeconds % 60);
  int milliseconds = (duration.inMilliseconds % 1000) ~/ 100;

  return '$minutes:${seconds.toString().padLeft(2, '0')}.$milliseconds';
}