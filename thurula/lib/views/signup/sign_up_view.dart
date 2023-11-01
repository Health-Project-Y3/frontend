import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thurula/services/auth/user_service.dart';
import 'package:thurula/views/signup/sign_up_question_view.dart';
import 'package:thurula/views/signup/sign_up_welcome_view.dart';
import 'package:thurula/views/widgets/toast_widget.dart';

import '../../providers/user_provider.dart';
import 'package:thurula/extensions/buildcontext/loc.dart';
class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isEmailValid = true;
  bool arePasswordsMatching = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
          child: Stack(
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
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 120,
                    right: 25,
                    left: 25,
                  ),
                  child: Image(
                    image: AssetImage('assets/images/signup.png'),
                    width: 300,
                    height: 180,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 300,
                  left: 16,
                  right: 16,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFieldWidget(
                              controller: firstNameController,
                              hintText: context.loc.register_page_FirstName,
                              isPassword: false,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFieldWidget(
                              controller: lastNameController,
                              hintText: context.loc.register_page_LastName,
                              isPassword: false,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // TextField for Username with validation
                      TextFieldWidget(
                        controller: usernameController,
                        hintText: context.loc.login_page_username,
                        isPassword: false,
                      ),
                      const SizedBox(height: 16),
                      // TextField for Email with validation
                      TextFieldWidget(
                        hintText: context.loc.register_page_Email,
                        isPassword: false,
                        icon: Icons.email,
                        controller: emailController,
                        isValid: isEmailValid,
                        updateValidation: (isValid) {
                          setState(() {
                            isEmailValid = isValid;
                          });
                        },
                        validationRegExp: emailRegExp,
                      ),
                      const SizedBox(height: 16),
                      // TextField for Password
                      TextFieldWidget(
                        hintText: context.loc.login_page_password,
                        isPassword: true,
                        icon: Icons.visibility,
                        controller: passwordController,
                      ),
                      const SizedBox(height: 16),

                      // TextField for Confirm Password
                      TextFieldWidget(
                        hintText: context.loc.register_page_PasswordConfirm,
                        isPassword: true,
                        icon: Icons.visibility,
                        controller: confirmPasswordController,
                        onChanged: (text) {
                          setState(() {
                            arePasswordsMatching =
                                passwordController.text == text;
                          });
                        },
                      ),

                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterWelcome(),
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
                          ElevatedButton(
                            onPressed: isNextButtonEnabled()
                                ? () async {
                                    try {
                                      var newuser = await UserService.register(
                                          firstNameController.text,
                                          lastNameController.text,
                                          emailController.text,
                                          passwordController.text,
                                          usernameController.text);
                                      final userProvider =
                                          Provider.of<UserProvider>(context,
                                              listen: false);
                                      userProvider.setUser(newuser!);
                                    } catch (e) {
                                      if (e is UsernameTakenException) {
                                        GFToast.showToast(
                                          context.loc.register_page_UsernameTakenError,
                                          context,
                                          toastPosition: GFToastPosition.BOTTOM,
                                          textStyle: TextStyle(
                                            color:Colors.black
                                          ),
                                          toastDuration: 3,
                                          backgroundColor: Colors.yellow,
                                        );
                                        return;
                                      } else {
                                        print(e);
                                        GFToast.showToast(
                                          context.loc.register_page_ToastError,
                                          context,
                                          toastPosition: GFToastPosition.BOTTOM,
                                          toastDuration: 3,
                                          backgroundColor: Colors.red,
                                        );
                                        return;
                                      }
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpViewQuestion(),
                                      ),
                                    );
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                  255, 220, 104, 145), // Pink button color
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              elevation: 2,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  context.loc.next,
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
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isNextButtonEnabled() {
    bool fieldsNotEmpty = firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty;

    return fieldsNotEmpty && isEmailValid && arePasswordsMatching;
  }
}

// Define a regular expression for email validation
final emailRegExp = RegExp(
  r'^[a-z0-9]+@[a-z]+\.com$',
);

class TextFieldWidget extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final IconData? icon;
  final TextEditingController? controller;
  final bool? isValid;
  final Function(bool)? updateValidation;
  final RegExp? validationRegExp;
  final Function(String)? onChanged;

  const TextFieldWidget({
    Key? key,
    required this.hintText,
    required this.isPassword,
    this.icon,
    this.controller,
    this.isValid,
    this.updateValidation,
    this.validationRegExp,
    this.onChanged,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: TextField(
        obscureText: widget.isPassword && _obscureText,
        controller: widget.controller,
        style: const TextStyle(color: Colors.grey),
        onChanged: (text) {
          if (widget.validationRegExp != null &&
              widget.updateValidation != null) {
            final isValid = widget.validationRegExp!.hasMatch(text);
            widget.updateValidation!(isValid);
          }
          if (widget.onChanged != null) {
            widget.onChanged!(text);
          }
        },
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 220, 104, 145),
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 220, 104, 145),
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: const Color.fromARGB(255, 220, 104, 145),
                  ),
                )
              : null,
          contentPadding: const EdgeInsets.all(10.0),
          errorText: widget.isValid == false ? 'Invalid' : null,
        ),
      ),
    );
  }
}
