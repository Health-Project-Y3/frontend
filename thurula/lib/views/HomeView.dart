import 'package:flutter/material.dart';
// import 'package:thurula/views/widgets/wave_widget.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:thurula/views/signup/Question2View.dart';
// import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(children: [Text('Home Page')]),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Handle back button press here
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 150, 0, 30),
              child: Center(
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(120, 50, 120, 50),
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 220, 104, 145),
                    textStyle:
                        const TextStyle(fontSize: 20, color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // <-- Radius
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Question2View()));
                  },
                  child: const Text("Pregnancy"),
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(120, 50, 120, 50),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 88, 119, 161),
                  textStyle: const TextStyle(fontSize: 20, color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // <-- Radius
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Question2View()));
                },
                child: const Text("Childcare"),
              ),
            ),
            ClipPath(
                clipper: WaveClipperTwo(flip: true, reverse: true),
                child: Container(
                  height: 236,
                  color: const Color.fromARGB(255, 220, 104, 145),
                ))
          ],
        ));
  }
}
