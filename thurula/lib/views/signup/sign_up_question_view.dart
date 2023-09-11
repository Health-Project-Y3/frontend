import 'package:flutter/material.dart';
import 'package:thurula/views/signup/sign_up_child_view.dart';
import 'package:thurula/views/signup/sign_up_pregnancy_view.dart';
import 'package:thurula/views/signup/sign_up_view.dart';

class SignUpViewQuestion extends StatelessWidget {
  const SignUpViewQuestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 30,
              right: 50,
              left: 50,
              child: Image.asset(
                'assets/images/logo2.png',
                height: 120,
              ),
            ),
            Positioned(
              top: 150,
              left: 16,
              right: 16,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPregnancyView(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                          color: Colors.grey,
                        ),
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Image(
                              image: AssetImage('assets/images/pregnant.png'),
                              width: 300,
                              height: 200,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            flex: 7,
                            child: Text(
                              "I am currently pregnant.",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpChildView(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                          color: Colors.grey,
                        ),
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Image(
                              image: AssetImage('assets/images/child.png'),
                              width: 300,
                              height: 200,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            flex: 7,
                            child: Text(
                              "I have a newborn baby.",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 16,
              bottom: 30,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpView(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      255, 220, 104, 145), // Pink button color
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  elevation: 2,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    Text(
                      "Back",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
