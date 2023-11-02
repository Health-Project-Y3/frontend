import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thurula/services/auth/user_service.dart';
import 'package:thurula/views/signup/sign_up_both_view1.dart';
import 'package:thurula/views/signup/sign_up_child_view.dart';
import 'package:thurula/views/signup/sign_up_pregnancy_view.dart';
import 'package:thurula/views/signup/sign_up_view.dart';

import '../../providers/user_provider.dart';
import 'package:thurula/extensions/buildcontext/loc.dart';

class SignUpViewQuestion extends StatelessWidget {
  const SignUpViewQuestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = context.read<UserProvider>().user!;
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
                    // Pregnant
                    ElevatedButton(
                      onPressed: () {
                        UserService.patchUser(user.id!, "pregnant", true);
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
                      child: Row(
                        children: [
                          const Expanded(
                            flex: 3,
                            child: Image(
                              image: AssetImage('assets/images/pregnant.png'),
                              width: 150,
                              height: 100,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 7,
                            child: Text(
                              context.loc.register_page2_Q1,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Child
                    ElevatedButton(
                      onPressed: () {
                        UserService.patchUser(user.id!, "pregnant", false);
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
                      child: Row(
                        children: [
                          const Expanded(
                            flex: 3,
                            child: Image(
                              image: AssetImage('assets/images/child.png'),
                              width: 150,
                              height: 100,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 7,
                            child: Text(
                              context.loc.register_page2_Q2,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Both
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpBothView1(),
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
                      child: Row(
                        children: [
                          const Expanded(
                            flex: 3,
                            child: Image(
                              image: AssetImage(
                                  'assets/images/pregnant_with_child.png'),
                              width: 150,
                              height: 100,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 7,
                            child: Text(
                              context.loc.register_page2_Q3,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    Text(
                      context.loc.back,
                      style: const TextStyle(
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
