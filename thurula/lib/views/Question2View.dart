import 'package:flutter/cupertino.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
// import 'package:thurula/views/widgets/wave_widget.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
// import 'package:provider/provider.dart';

class Question2View extends StatelessWidget {
  const Question2View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Welcome Page'),
        ),
        body: Column(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipperTwo(flip: true),
              child: Container(
                height: 400,
                color: const Color.fromARGB(255, 220, 104, 145),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                    child: Column(
                      children: [
                        Text("Do you know your due date?",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        
                        Text("Enter due date given by doctor",
                            style:
                                TextStyle(color: Colors.white, fontSize: 10)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(180, 60, 0, 0),
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(50, 15, 50, 15),
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 88, 119, 161),
                    textStyle:
                        const TextStyle(fontSize: 15, color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // <-- Radius
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Next"),
                ),
              ),
            ),
          ],
        ));
  }
}
