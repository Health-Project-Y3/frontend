import 'package:flutter/material.dart';
import 'package:thurula/views/menu_view.dart';

class WelcomeHomeView extends StatelessWidget {
  const WelcomeHomeView({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          // appbar
          // appBar: AppBar(
          //   backgroundColor: const Color.fromARGB(255, 220, 104, 145),
          //   title: const Text(
          //     'Welcome',
          //     style: TextStyle(
          //       fontSize: 20,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          //   ),
          body: Column(
            children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: Image(
                    image: AssetImage('assets/images/landing.jpg'),
                    width: 300,
                    height: 400,
                  ),
                ),
              const Center(
                // add image
                child: Padding(
                  padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
                  // add 2 text fields
                  child: Text(
                    "New Life, Tiny Steps",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 220, 104, 145),
                    ),
                  ),
                ),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 30),
                  child: Text(
                      "We just need a few quick answers from you to personalize your experience",
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(color: Color.fromARGB(255, 135, 135, 135))),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MenuView(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                          255, 88, 119, 161), // Set the button color
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 120),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: const Text(
                      'Let\'s get started!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
