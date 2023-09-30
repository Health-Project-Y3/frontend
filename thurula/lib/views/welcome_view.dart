import 'package:flutter/material.dart';
import 'package:thurula/views/menu_view.dart';
import 'package:thurula/extensions/buildcontext/loc.dart';

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
               Center(
                // add image
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                  // add 2 text fields
                  child: Text(
                    context.loc.welcome_page_Caption1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 220, 104, 145),
                    ),
                  ),
                ),
              ),
               Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 30),
                  child: Text(
                    context.loc.welcome_page_Caption2,
                      textAlign: TextAlign.center,
                      style:
                      const TextStyle(color: Color.fromARGB(255, 135, 135, 135))),
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
                    child: Text(
                      context.loc.welcome_page_GetStartedButton,
                      style: const TextStyle(
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
