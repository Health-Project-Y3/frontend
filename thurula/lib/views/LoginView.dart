import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Second Route'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
            child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Image(
                  image: AssetImage('assets/images/logo2.png'), height: 150),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(width: 2, color: Colors.red)),
                  labelText: 'Username',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(width: 2, color: Colors.red)),
                  labelText: 'Password',
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(120, 10, 120, 10),
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 88, 119, 161),
                textStyle: const TextStyle(fontSize: 20, color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // <-- Radius
                ),
              ),
              onPressed: null,
              child: const Text('Login'),
            )
          ],
        )),
      ),
    );
  }
}
