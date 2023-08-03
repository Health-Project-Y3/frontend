import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:thurula/views/widgets/wave_widget.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'HomeView.dart';
import 'Question2View.dart';
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
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                    child: Column(
                      children: [
                        const Text("Are you pregnant?",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        Center(
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(100, 30, 20, 0),
                                child: ElevatedButton(
                                    style: TextButton.styleFrom(
                                      // padding: const EdgeInsets.fromLTRB(
                                      //     100, 10, 100, 10),
                                      backgroundColor: Colors.white,
                                      textStyle: const TextStyle(fontSize: 15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            30), // <-- Radius
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('YES',
                                        style: TextStyle(color: Colors.black))),
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 30, 20, 0),
                                  child: ElevatedButton(
                                      style: TextButton.styleFrom(
                                        // padding: const EdgeInsets.fromLTRB(
                                        //     100, 10, 100, 10),
                                        backgroundColor: Colors.white,
                                        textStyle:
                                            const TextStyle(fontSize: 15),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              30), // <-- Radius
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('NO',
                                          style:
                                              TextStyle(color: Colors.black)))),
                            ],
                          ),
                        )
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeView()));
                  },
                  child: const Text("Next"),
                ),
              ),
            ),
          ],
        ));
  }
}
