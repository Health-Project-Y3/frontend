import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:thurula/views/widgets/wave_widget.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import '../../MenuView.dart';
import '../../Question2View.dart';

// import 'package:provider/provider.dart';

class VisionMenuView extends StatelessWidget {
  const VisionMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    // final model = Provider.of<HomeModel>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Row(children: [Text('Vision Test')]),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MenuView()));
                    })),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 10),
              child: Center(
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(120, 30, 120, 30),
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
                  child: const Text("Color Blind"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Center(
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(120, 30, 120, 30),
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 88, 119, 161),
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
                  child: const Text("Astigmatism"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Center(
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(120, 30, 120, 30),
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 88, 119, 161),
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
                  child: const Text("Visual Activity"),
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(120, 30, 120, 30),
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
                child: const Text("Eye Diseases"),
              ),
            ),
          ],
        ));
  }
}
