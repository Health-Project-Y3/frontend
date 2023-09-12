import 'dart:async';
import 'package:flutter/material.dart';
import 'package:thurula/views/pregnancy/pregnancy_exercise_recommendations_view.dart';

// first trimester exercises
List<String> exerciseNamesT1 = [
  "Diaphragmatic Breath with Pelvic Floor Activation",
  "P.sit to Stand",
  "Standing Abs",
  "Pelvis Articulation",
  "Butt Press"
];

// first trimester exercise descriptions
List<String> exerciseDescsT1 = [
  "Stand with feet wide, knees soft, eyes closed and hands on belly. Take deep breaths into the belly allowing it to expand and contract fully. As you exhale, think of stopping the flow of urine, contracting vaginally, rectally, and feeling how the tailbone naturally flexes without adding any movement there. As you exhale and contract the pelvic floor, add pulling the abdominals in and up as if you were riding an elevator from the basement to the top floor of a building. All of these sensations account for a properly executed Kegel.",
  "Stand tall with feet, knees, and thighs together and turn your palms forward. Hinge back at your hips into a p.sit, keeping knees over ankles and spine long and straight to stretch the glutes while sweeping the arms overhead. Drive up through the floor, pressing your feet down to come back to stand with the arms by your side. Add the pelvic floor contraction as you stand back up.",
  "Tap one toe straight forward, angling your hip bones up toward the ceiling and squeezing into your glutes while leaning back. Be sure to keep your ribcage hugged together in the front so you don’t sink into the lower back. Reach your arms overhead with palms facing forward. Lift your front leg up while pressing your arms down, recruiting your abdominals as you do in your everyday life and working on stability. If needed, feel free to hold onto the back of a chair.",
  "Step one foot back as if you are mid-step and lower your back heel down. Front knee is slightly bent. Start to open and close your hips, rotating your pelvis while keeping your feet pointing straight forward to get some movement in the hips. For an added challenge for the upper body, grab onto light weights and pull one elbow back at a time, moving the arms as you twist your hips.",
  "Step one foot back as if you are mid-step and lower your back heel down. Front knee is slightly bent. Start to open and close your hips, rotating your pelvis while keeping your feet pointing straight forward to get some movement in the hips. For an added challenge for the upper body, grab onto light weights and pull one elbow back at a time, moving the arms as you twist your hips."
];

// second trimester exercises
List<String> exerciseNamesT2 = [
  "Step Back",
  "Stagger Row",
  "Rotating Stagger",
  "Internal 45 with Side Stretch",
  "Leg Lift"
];

// second trimester exercise descriptions
List<String> exerciseDescsT2 = [
  "Step one foot back as if you are mid-step and lower your back heel down, leaning your body forward to create one long diagonal line through the crown of your head and down through the back heel, arms reaching back behind you. Keeping your back leg straight, lift the heel high, squeeze the back glute and push through the ball of the foot to engage your glutes while reaching your arms overhead. Feel a huge stretch on the hip flexor which tends to get very tight from pregnancy. From there, return to start position.",
  "Holding onto light hand weights or water bottles, sit your hips back into a p.sit, hinging at your hips with both knees deeply bent and weights reaching on a low diagonal. Keeping your knees in line, bring one foot back behind you pressing through the ball of the foot. Drive up through both feet to come to full hip extension and squeeze your weights in by your ribs, engaging the glutes and postural muscles.",
  "From your stagger position, keep your standing foot forward and pivot your hips and torso toward your front leg, rotating on a 45-degree angle out to the side. Extend the weights in this internal stagger position. Come back to center, rowing your arms back.",
  "From your stagger position, keep your standing foot forward and pivot your hips and torso toward your front leg, rotating on a 45-degree angle out to the side. Extend the weights in this internal stagger position. Come back to center, rowing your arms back.",
  "Start on all fours with a neutral spine, hands in line with shoulders and hips over knees. Keep your abdominals lifting to the ceiling so your back stays neutral. Extend one leg straight back behind you, tapping your toes to the floor. Lift and lower the leg while keeping your baby hugged into your spine, pumping through the glutes."
];

// third trimester exercises
List<String> exerciseNamesT3 = [
  "Fire Hydrant",
  "Kneeling Hip Flexor Stretch",
  "Intercoastal Kneeling Stretch",
  "Hamstring Press",
  "Bridge"
];

// third trimester exercise descriptions
List<String> exerciseDescsT3 = [
  "Lean your upper body forward with a soft bend in your knees and stagger one foot back behind you, interlacing your hands. Begin to lift and lower the back leg out to the side, squeezing the outer glute and engaging through the pelvic floor as you come back to stagger. Feel free to hold onto something for balance if needed.",
  "From a kneeling position, step one foot directly out in front of you and reach your arms forward at shoulder height. Squeezing your back glute, shift your hips forward and stretch the arm of the kneeling leg up to the ceiling for a deep hip flexor stretch. Always maintain a squeeze on the kneeling glute. Come back to start position.",
  "From your kneeling inner thigh stretch, step your front leg out to the side, keeping knee in line with second toe and W the arms. Shift your weight into the foot on the floor, stretching open your inner thighs. Reach the arm of your kneeling leg up and over to corner of the room, breathing into all the muscles between your ribs that may not have full excursion of the breath due to your growing belly.",
  "Come to a side-lying position on a prenatal wedge or a stack of pillows to keep your heart above your baby. Bend your knees so they are in 90-degree angles, knees in line with hips and feet in line with knees. Lift your top leg and flex your foot and then extend the leg straight back behind you, working into the back of the leg and glute.",
  "Come to a side-lying position on a prenatal wedge or a stack of pillows to keep your heart above your baby. Bend your knees so they are in 90-degree angles, knees in line with hips and feet in line with knees. Lift your top leg and flex your foot and then extend the leg straight back behind you, working into the back of the leg and glute."
];

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
          title: Text(
              _getExerciseName(exercise.split(',')[0], exercise.split(',')[1]),
              // exerciseNamesT1[int.parse(exercise.split(',')[0])],
              style: const TextStyle(
                color: Color.fromARGB(255, 220, 104, 145),
                fontWeight: FontWeight.bold,
              )
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  _getExerciseDesc(exercise.split(',')[0], exercise.split(',')[1]),
                  style: const TextStyle(
                    //   hex color #878787
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
        title: Text(_getExerciseName(exercise.split(',')[0], exercise.split(',')[1])),
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

// function to return the exercise name
String _getExerciseName(String trimester, String index) {
  switch (trimester) {
    case '1':
      return exerciseNamesT1[int.parse(index)-1];
    case '2':
      return exerciseNamesT2[int.parse(index)-1];
    case '3':
      return exerciseNamesT3[int.parse(index)-1];
    default:
      return "Default";
  }
}

// function to return the exercise description
String _getExerciseDesc(String trimester, String index) {
  switch (trimester) {
    case '1':
      return exerciseDescsT1[int.parse(index)-1];
    case '2':
      return exerciseDescsT2[int.parse(index)-1];
    case '3':
      return exerciseDescsT3[int.parse(index)-1];
    default:
      return "Default";
  }
}