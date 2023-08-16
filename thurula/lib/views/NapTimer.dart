import 'dart:async';
import 'package:thurula/services/local_service.dart';
import 'package:thurula/services/naps_service.dart';
import 'package:thurula/views/NapDetails.dart';
import 'package:flutter/material.dart';

import '../models/naptimes_model.dart';

class NapTimer extends StatefulWidget {
  const NapTimer({super.key});

  @override
  State<NapTimer> createState() => _NapTimerState();
}

bool isSleeping = false;
DateTime? startTime;
DateTime? endTime;

class _NapTimerState extends State<NapTimer> {
  String formatTime(int milliSeconds) {
    var secs = milliSeconds ~/ 1000;
    var hours = (secs ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (secs % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  late Stopwatch stopwatch;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();
    timer = Timer.periodic(new Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void handleStopwatchStartStop() {
    if (stopwatch.isRunning) {
      stopwatch.stop();
      endTime = DateTime.now();
      isSleeping = false; // Timer is stopped, so Mary is not sleeping.
    } else {
      stopwatch.start();
      startTime = DateTime.now();
      isSleeping = true; // Timer is started, so Mary's sleep timer is running.
    }
    setState(() {});
  }

  void resetStopwatch() {
    stopwatch.reset();
    setState(() {});
  }

  void saveData() {
    LocalService.getCurrentBabyId().then((babyId) {
      NapService.createNap(
        NapTimes(
          babyId: babyId,
          startTime: startTime,
          endTime: endTime,
        ),
      ).then((napId) {
        setState(() {
          napId = napId;
        });
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Baby Nap Timer'),
        // centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
              isSleeping ? 'Mary is sleeping' : 'Start Mary\'s sleep timer',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 40),
            // spacing between "Mary is sleeping" text and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: handleStopwatchStartStop,
                  backgroundColor: Colors.lightBlueAccent,
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
                  backgroundColor: Colors.lightBlueAccent,
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
                foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 220, 104, 145),
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
            color: const Color.fromARGB(255, 220, 104, 145),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            time,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 60,
                color: Colors.black54),
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        header,
        style: const TextStyle(color: Colors.blue),
      )
    ],
  );
}