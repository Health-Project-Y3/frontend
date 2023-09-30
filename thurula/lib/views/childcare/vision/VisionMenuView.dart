import 'package:flutter/material.dart';
import 'package:thurula/views/childcare/child_care_menu_view.dart';
import 'package:thurula/views/childcare/vision/eye_disease_list.dart';
// import '../../signup/Question2View.dart';
import './SnellenCardView.dart';

class VisionMenuView extends StatelessWidget {
  const VisionMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    // final model = Provider.of<HomeModel>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Row(children: [Text('Vision Test')]),
          backgroundColor: const Color.fromARGB(255, 220, 104, 145),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChildCareMenuView()));
                    })),
          ],
        ),
        body: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(0, 100, 0, 10),
            //   child: Center(
            //     child: ElevatedButton(
            //       style: TextButton.styleFrom(
            //         padding: const EdgeInsets.fromLTRB(120, 30, 120, 30),
            //         foregroundColor: Colors.white,
            //         backgroundColor: const Color.fromARGB(255, 220, 104, 145),
            //         textStyle:
            //             const TextStyle(fontSize: 20, color: Colors.white),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(10), // <-- Radius
            //         ),
            //       ),
            //       onPressed: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => const Question2View()));
            //       },
            //       child: const Text("Color Blind"),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            //   child: Center(
            //     child: ElevatedButton(
            //       style: TextButton.styleFrom(
            //         padding: const EdgeInsets.fromLTRB(120, 30, 120, 30),
            //         foregroundColor: Colors.white,
            //         backgroundColor: const Color.fromARGB(255, 88, 119, 161),
            //         textStyle:
            //             const TextStyle(fontSize: 20, color: Colors.white),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(10), // <-- Radius
            //         ),
            //       ),
            //       onPressed: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => const Question2View()));
            //       },
            //       child: const Text("Astigmatism"),
            //     ),
            //   ),
            // ),
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
                            builder: (context) => const SnellenCardView()));
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
                          builder: (context) => const EyeDiseaseList()));
                },
                child: const Text("Eye Diseases"),
              ),
            ),
          ],
        ));
  }
}
