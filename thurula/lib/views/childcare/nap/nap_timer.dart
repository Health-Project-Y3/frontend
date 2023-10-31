import 'dart:async';
import 'package:thurula/views/childcare/nap/nap_details.dart';
import 'package:flutter/material.dart';
import 'package:thurula/services/naps_service.dart';
import 'package:thurula/models/naptimes_model.dart';

class NapTimer extends StatefulWidget {
  @override
  State<NapTimer> createState() => _NapTimerState();
}

class _NapTimerState extends State<NapTimer> {
  late Stopwatch stopwatch;
  late Timer timer;
  bool isSleeping = false;

  String formatTime(int milliSeconds) {
    var secs = milliSeconds ~/ 1000;
    var hours = (secs ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (secs % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();
    timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer.cancel();
    stopwatch.stop(); // Stop the stopwatch when the widget is disposed
    super.dispose();
  }

  void handleStopwatchStartStop() {
    if (stopwatch.isRunning) {
      stopwatch.stop();
      isSleeping = false;
    } else {
      stopwatch.start();
      isSleeping = true;
    }
    setState(() {});
  }

  void resetStopwatch() {
    stopwatch.reset();
    setState(() {});
  }

  Future<void> saveData() async {
    print('Save Data button pressed');
    print(stopwatch.isRunning);
    if (stopwatch.isRunning) {
      stopwatch.stop();
      isSleeping = false;

      DateTime startTime = DateTime.now()
          .subtract(Duration(milliseconds: stopwatch.elapsedMilliseconds));
      DateTime endTime = DateTime.now();

      NapTimes newNap = NapTimes(
        babyId: '64b01605b55b765169e1c9b6', // Replace with your baby's ID
        startTime: startTime,
        endTime: endTime,
      );

      try {
        NapTimes createdNap = await NapService.createNap(newNap);
        print('Created Nap ID: ${createdNap.id}');
        resetStopwatch();
      } catch (e) {
        print('Error creating nap record: $e');
      }
    } else {
      DateTime startTime = DateTime.now()
          .subtract(Duration(milliseconds: stopwatch.elapsedMilliseconds));
      DateTime endTime = DateTime.now();

      NapTimes newNap = NapTimes(
        babyId: '64b01605b55b765169e1c9b6', // Replace with your baby's ID
        startTime: startTime,
        endTime: endTime,
      );

      try {
        NapTimes createdNap = await NapService.createNap(newNap);
        print('Created Nap ID: ${createdNap.id}');
        resetStopwatch();
      } catch (e) {
        print('Error creating nap record: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 220, 104, 145),
        title: const Text(
          'Baby Nap Timer',
          style: TextStyle(
            color: Colors.white, // Title color
          ),
        ),
        // Background color of the app bar
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white, // Back icon color
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NapDetails()),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildTimeCard(
                  time:
                      formatTime(stopwatch.elapsedMilliseconds).substring(0, 2),
                  header: "HOURS",
                ),
                const SizedBox(
                  width: 10,
                ),
                buildTimeCard(
                  time:
                      formatTime(stopwatch.elapsedMilliseconds).substring(3, 5),
                  header: "MINUTES",
                ),
                const SizedBox(
                  width: 10,
                ),
                buildTimeCard(
                  time:
                      formatTime(stopwatch.elapsedMilliseconds).substring(6, 8),
                  header: "SECONDS",
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const SizedBox(height: 30),
            Center(
              child: Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/sleeping_image.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              isSleeping ? 'Baby is sleeping' : 'Start sleep timer',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 88, 119, 161),
              ),
            ),
            const SizedBox(
                height:
                    40), // spacing between "Mary is sleeping" text and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: handleStopwatchStartStop,
                  backgroundColor: Color.fromARGB(255, 88, 119, 161),
                  child: Icon(
                    stopwatch.isRunning ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                FloatingActionButton(
                  onPressed: resetStopwatch,
                  backgroundColor: Color.fromARGB(255, 88, 119, 161),
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveData, // saveData function
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 220, 104, 145),
              ),
              child: const Text('Save Data'),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildTimeCard({required String time, required String header}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        decoration: BoxDecoration(
            color: Colors.lightBlue[50],
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            time,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 60,
                color: Colors.black54),
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        header,
        style: TextStyle(color: Colors.blue),
      )
    ],
  );
}
