import 'package:flutter/material.dart';
import 'package:thurula/services/auth/user_service.dart';
import 'package:thurula/views/welcome_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 25,
                ),
                child: Center(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 50,
                          right: 25,
                        ),
                        child: Image(
                          image: AssetImage('assets/images/login.png'),
                          height: 400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 30,
                          top: 50,
                          right: 30,
                        ),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.grey),
                          controller: usernameController,
                          decoration: const InputDecoration(
                            hintText: 'Username',
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromRGBO(220, 104, 145, 1)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 220, 104, 145),
                                )),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 30,
                          top: 20,
                          right: 30,
                        ),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.grey),
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color.fromARGB(255, 220, 104, 145),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 220, 104, 145),
                                )),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 30,
                          top: 30,
                          right: 30,
                          bottom: 20, // Add bottom padding
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // home page
                              if (await UserService().login(
                                  usernameController.text,
                                  passwordController.text))
                              // if (usernameController.text == "admin@gmail.com" &&
                              //     passwordController.text == "password")
                              {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WelcomeHomeView(
                                            username:
                                                usernameController.text)));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Invalid Credentials')));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please fill input')),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 220, 104, 145),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Image.asset(
                'assets/images/logo2.png',
                height: 120,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
