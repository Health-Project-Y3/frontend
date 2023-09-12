import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thurula/services/auth/user_service.dart';
import 'package:thurula/views/menu_view.dart';
import 'package:thurula/views/signup/sign_up_question_view.dart';

import '../../providers/user_provider.dart';

class SignUpPregnancyView extends StatefulWidget {
  const SignUpPregnancyView({Key? key}) : super(key: key);

  @override
  _SignUpPregnancyViewState createState() => _SignUpPregnancyViewState();
}

class _SignUpPregnancyViewState extends State<SignUpPregnancyView> {
  DateTime? selectedDueDate;
  DateTime? selectedPredictedDate;

  bool isNextButtonEnabled() {
    return selectedDueDate != null;
  }

  void calculateDueDateFromPredicted() {
    if (selectedPredictedDate != null) {
      final calculatedDueDate = selectedPredictedDate!
          .add(Duration(days: 270)); // 270 days = 9 months
      setState(() {
        selectedDueDate = calculatedDueDate;
      });
    }
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
            const Positioned(
              top: 150,
              left: 16,
              right: 16,
              child: Column(
                children: [
                  Text(
                    'Do you know your due date?',
                    style: TextStyle(
                      color: Color.fromARGB(255, 220, 104, 145),
                      fontFamily: 'Inter',
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Enter due date given by doctor',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Inter',
                      fontSize: 14,
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
                      lastDate: DateTime(DateTime.now().year, DateTime.now().month + 11, DateTime.now().day),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          selectedDueDate = value;
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
                          selectedDueDate != null
                              ? '${DateFormat('yyyy-MM-dd').format(selectedDueDate!)}'
                              : 'Enter Due Date',
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
              top: 300,
              left: 16,
              right: 16,
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 220, 104, 145),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: const Center(
                      child: Text(
                        'OR',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Calculate your due date.',
                    style: TextStyle(
                      color: Color.fromARGB(255, 220, 104, 145),
                      fontFamily: 'Inter',
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Enter the day of last menstrual period.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Inter',
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 440,
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
                          selectedPredictedDate = value;
                          // Calculate and set the due date from the predicted date
                          calculateDueDateFromPredicted();
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
                          selectedPredictedDate != null
                              ? '${DateFormat('yyyy-MM-dd').format(selectedPredictedDate!)}'
                              : 'Enter Date',
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
              left: 16,
              bottom: 20,
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
            Positioned(
              right: 16,
              bottom: 20,
              child: ElevatedButton(
                onPressed: isNextButtonEnabled()
                    ? () {
                  UserService.getUser(context.read<UserProvider>().user!.id!).then(
                    (u)=>{
                      u?.dueDate = selectedDueDate,
                      u?.conceptionDate = DateTime(selectedDueDate!.year, selectedDueDate!.month - 10, selectedDueDate!.day),
                      UserService.updateUser(u!.id!, u)
                    }
                  );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MenuView(),
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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Done",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Icon(
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
