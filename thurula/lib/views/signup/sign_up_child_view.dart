import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thurula/providers/baby_provider.dart';
import 'package:thurula/services/auth/user_service.dart';
import 'package:thurula/services/baby_service.dart';
import 'package:thurula/services/local_service.dart';
import 'package:thurula/views/childcare/child_home_view.dart';
import 'package:thurula/views/menu_view.dart';
import 'package:thurula/views/signup/sign_up_question_view.dart';
import '../../models/baby_model.dart';
import '../../providers/user_provider.dart';
import 'package:thurula/extensions/buildcontext/loc.dart';

class SignUpChildView extends StatefulWidget {
  const SignUpChildView({Key? key}) : super(key: key);

  @override
  _SignUpChildViewState createState() => _SignUpChildViewState();
}

class _SignUpChildViewState extends State<SignUpChildView> {
  DateTime? selectedDate;
  bool isMaleSelected = false;
  bool isFemaleSelected = false;

  final TextEditingController babyNameController = TextEditingController();

  bool isNextButtonEnabled() {
    return selectedDate != null &&
        (isMaleSelected || isFemaleSelected) &&
        babyNameController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Stack(
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
              top: 170,
              left: 16,
              right: 16,
              child: Column(
                children: [
                  Text(
                    context.loc.register_page3_Q1,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 220, 104, 145),
                      fontFamily: 'Inter',
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 200,
              left: 16,
              right: 16,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          selectedDate = value;
                        });
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 220, 104, 145)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedDate != null
                              ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                              : context.loc.register_page3_Q1placeholder,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Inter',
                            fontSize: 16,
                          ),
                        ),
                        const Icon(
                          Icons.calendar_today,
                          color: Color.fromARGB(255, 220, 104, 145),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 280,
              left: 16,
              right: 16,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: babyNameController,
                  decoration: InputDecoration(
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
                    labelText: context.loc.register_page3_Q2placeholder,
                    labelStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 380,
              left: 16,
              right: 16,
              child: Column(
                children: [
                  Text(
                    context.loc.register_page3_Q2,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 220, 104, 145),
                      fontFamily: 'Inter',
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 430,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isMaleSelected = true;
                        isFemaleSelected = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isMaleSelected
                          ? const Color.fromARGB(255, 220, 104, 145)
                          : Colors.grey,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.male,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          context.loc.register_page3_Male,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isMaleSelected = false;
                        isFemaleSelected = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isFemaleSelected
                          ? const Color.fromARGB(255, 220, 104, 145)
                          : Colors.grey,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.female,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          context.loc.register_page3_Female,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 710,
              left: 16,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpViewQuestion(),
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
            Positioned(
              top: 710,
              right: 16,
              child: ElevatedButton(
                onPressed: isNextButtonEnabled()
                    ? () {
                        BabyService.createBaby(Baby(
                                fname: babyNameController.text,
                                lname: "",
                                birthDate: selectedDate,
                                ownerIDs: [
                                  context.read<UserProvider>().user?.id ?? ''
                                ],
                                gender: isMaleSelected ? "male" : "female"))
                            .then((baby) => {
                                  UserService.addBaby(
                                      context.read<UserProvider>().user!.id!,
                                      baby.id!),
                                  LocalService.setCurrentBabyId(baby.id!),
                                  context.read<BabyProvider>().setBaby(baby),
                                });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChildHomeView(),
                          ),
                        );
                      }
                    : null,
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
                    Text(
                      context.loc.save,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const Icon(
                      Icons.check,
                      color: Colors.white,
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
