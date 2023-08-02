import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NapTimer extends StatefulWidget {
  const NapTimer({super.key});

  @override
  State<NapTimer> createState() => _NapTimerState();
}
bool isSleeping = false;


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
    timer = new Timer.periodic(new Duration(milliseconds: 30), (timer) {
      setState(() {

      });
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
      isSleeping = false; // Timer is stopped, so Mary is not sleeping.
    } else {
      stopwatch.start();
      isSleeping = true; // Timer is started, so Mary's sleep timer is running.
    }
    setState(() {});
  }



  void resetStopwatch(){
    stopwatch.reset();
    setState(() {

    });
  }

  void saveData(){

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Nap Timer'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Add your back button functionality here
            Navigator.of(context).pop();
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
                  time: formatTime(stopwatch.elapsedMilliseconds).substring(0, 2),
                  header: "HOURS",
                ),
                SizedBox(width: 10,),
                buildTimeCard(
                  time: formatTime(stopwatch.elapsedMilliseconds).substring(3, 5),
                  header: "MINUTES",
                ),
                SizedBox(width: 10,),
                buildTimeCard(
                  time: formatTime(stopwatch.elapsedMilliseconds).substring(6, 8),
                  header: "SECONDS",
                ),
                SizedBox(width: 10,),
              ],
            ),
            SizedBox(height: 30), // Add some spacing between timer card and image
            Image.asset(
              'assets/images/sleeping_image.png', // Replace with your image asset path
              width: 150,
              height: 150,
            ),
            SizedBox(height: 10), // Add some spacing between image and "Mary is sleeping" text
            Text(
              isSleeping ? 'Mary is sleeping' : 'Start Mary\'s sleep timer',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 40), // Add some spacing between "Mary is sleeping" text and buttons
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
                SizedBox(width: 50,),
                FloatingActionButton(
                  onPressed: resetStopwatch,
                  backgroundColor: Colors.lightBlueAccent,
                  child: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveData, // Add your saveData function here
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 220, 104, 145),
                onPrimary: Colors.white,
              ),
              child: Text('Save Data'),
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
          color:const Color.fromARGB(255, 220, 104, 145),
          borderRadius: BorderRadius.circular(20)
        ),
        child: Padding(padding: EdgeInsets.all(8.0),
        child: Text(time,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60, color: Colors.black54 ),),),
      ),
      SizedBox(height: 10,),
      Text(header, style: TextStyle(color: Colors.blue),)
    ],
  );
}















//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: DefaultTabController(
//         length: 3,
//         child: Scaffold(
//           appBar: AppBar(
//             bottom: PreferredSize(
//               preferredSize: const Size.fromHeight(48.0), // height of  TabBar
//               child: Container(
//                 color: const Color.fromARGB(255, 220, 104, 145),
//                 child: const TabBar(
//                   tabs: [
//                     Tab(
//                       text: "Start Nap",
//                     ),
//                     Tab(
//                       text: "Nap Details",
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             title: const Text('Nap Tracker'),
//           ),
//
//
//           body:  const TabBarView(
//             children: [
//                 Text("First trimester"),
//             ],
//
//
//           ),
//         ),
//       ),
//     );
//   }
// }