import 'package:flutter/material.dart';
import 'package:thurula/views/login_view.dart';
import 'package:thurula/views/signup/sign_up_view.dart';
import 'package:thurula/extensions/buildcontext/loc.dart';

class RegisterWelcome extends StatelessWidget {
  const RegisterWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                top: 40,
                right: 50,
                left: 50,
                child: Image.asset(
                  'assets/images/logo2.png',
                  height: 120,
                ),
              ),
              Center(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 100,
                        right: 25,
                        left: 25,
                      ),
                      child: Image(
                        image: AssetImage('assets/images/landing.jpg'),
                        width: 300,
                        height: 400,
                      ),
                    ),
                     Padding(
                      padding: const EdgeInsets.only(
                        top: 0,
                        right: 25,
                        left: 25,
                      ),
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
                     Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                        right: 25,
                        left: 25,
                      ),
                      child: Text(
                        context.loc.welcome_page_Caption2,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          elevation: 2, // Add elevation to the button
                        ),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              context.loc.welcome_page_GetStartedButton,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginView(),
                          ),
                        );
                      },
                      child:  Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: context.loc.welcome_page_AlreadyHaveAccount,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(
                              text: context.loc.welcome_page_SignIn,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 220, 104, 145),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
