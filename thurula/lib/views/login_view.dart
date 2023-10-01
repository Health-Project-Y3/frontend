import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thurula/extensions/buildcontext/loc.dart';
import 'package:thurula/providers/user_provider.dart';
import 'package:thurula/services/auth/user_service.dart';
import 'package:thurula/views/signup/sign_up_welcome_view.dart';
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
                          left: 40,
                          top: 0,
                          right: 30,
                        ),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.grey),
                          controller: usernameController,
                          decoration:  InputDecoration(
                            hintText: context.loc.login_page_username,
                            hintStyle: const TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromRGBO(220, 104, 145, 1)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 220, 104, 145),
                                )),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return context.loc.login_page_usernamePrompt;
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 40,
                          top: 10,
                          right: 30,
                        ),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.grey),
                          controller: passwordController,
                          obscureText: true,
                          decoration:  InputDecoration(
                            hintText: context.loc.login_page_password,
                            hintStyle: const TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color.fromARGB(255, 220, 104, 145),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 220, 104, 145),
                                )),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return context.loc.login_page_passwordPrompt;
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
                          bottom: 5,
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final context = _formKey.currentContext;
                              // home page
                              if (await UserService.login(
                                  usernameController.text,
                                  passwordController.text)) {
                                final userProvider = Provider.of<UserProvider>(
                                    context!,
                                    listen: false);
                                final user = await UserService.getByUsername(usernameController.text);
                                if (user != null) {
                                  userProvider.setUser(user);
                                }
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WelcomeHomeView(
                                            username:
                                                usernameController.text)));
                              } else {
                                ScaffoldMessenger.of(context!).showSnackBar(
                                     SnackBar(
                                        content:Text(context.loc.login_page_InvalidCredentials)));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(
                                    content: Text(context.loc.login_page_EmptyInputPrompt)),
                              );
                            }
                          },

                          // login button
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 220, 104, 145),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          child: Text(
                            context.loc.login_page_login_button,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterWelcome(),
                            ),
                          );
                        },
                        child:  Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: context.loc.login_page_noAccountQuestion,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              TextSpan(
                                text:  context.loc.login_page_register,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 220, 104, 145),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
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
