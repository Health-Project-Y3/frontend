import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thurula/views/menu_view.dart';

class AddNewBaby extends StatefulWidget {
  const AddNewBaby({Key? key}) : super(key: key);

  @override
  _AddNewBaby createState() => _AddNewBaby();
}

class _AddNewBaby extends State<AddNewBaby> {
  DateTime? selectedDate;
  bool isMaleSelected = true;
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
            const Positioned(
              top: 170,
              left: 16,
              right: 16,
              child: Column(
                children: [
                  Text(
                    'When was your baby born?',
                    style: TextStyle(
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
                              ? '${DateFormat('yyyy-MM-dd').format(selectedDate!)}'
                              : 'Enter Baby\'s Birthday',
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
                    labelText: 'Enter Baby\'s Name',
                    labelStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            const Positioned(
              top: 380,
              left: 16,
              right: 16,
              child: Column(
                children: [
                  Text(
                    'What is the gender of your baby?',
                    style: TextStyle(
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
                    child: const Row(
                      children: [
                        Icon(
                          Icons.male,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Male",
                          style: TextStyle(
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
                    child: const Row(
                      children: [
                        Icon(
                          Icons.female,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Female",
                          style: TextStyle(
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
              left: 16,
              bottom: 20,
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
                        //create baby for user
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