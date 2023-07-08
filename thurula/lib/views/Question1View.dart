import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:thurula/views/widgets/wave_widget.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
// import 'package:provider/provider.dart';

class Question1View extends StatelessWidget {
  const Question1View({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    // final model = Provider.of<HomeModel>(context);

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
                  child: Text("Are you pregnant?",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
                child: Text("hi",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: Color.fromARGB(255, 220, 104, 145))),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 88, 119, 161),
                    textStyle:
                        const TextStyle(fontSize: 15, color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80), // <-- Radius
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Let's get started"),
                ),
              ),
            ),
          ],
        ));
  }
}
