import 'package:flutter/material.dart';
import 'package:thurula/views/sign_up_view.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
// import 'package:provider/provider.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key, required this.username});

  final String username;

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
                  child: Image(
                      image: AssetImage('assets/images/logo3.png'),
                      height: 150),
                ),
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
                child: Text(
                    "We just need a few quick answers from you to personalize your experience",
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpView()));
                  },
                  child: const Text("Let's get started"),
                ),
              ),
            ),
          ],
        ));
  }
}
