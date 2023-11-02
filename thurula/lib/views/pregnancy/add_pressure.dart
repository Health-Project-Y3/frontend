import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thurula/models/user_bp_model.dart';
import 'package:thurula/services/user_bp_service.dart';
import 'package:thurula/views/pregnancy/view_bp_records.dart';

import '../../services/local_service.dart';
import 'mother_health_tracker.dart';

class AddPressurePage extends StatefulWidget {
  @override
  _AddPressurePageState createState() => _AddPressurePageState();
}

class _AddPressurePageState extends State<AddPressurePage> {
  DateTime? _selectedDate;
  TextEditingController bloodPressureController = TextEditingController();

  Future<UserBp> _getLastBloodPressure() async {
    try {

      List<UserBp> userBps = await UserBpService.getUserBps('650a6c285a1bbcfe70b8ad08', null, null); // Replace with your actual user ID
      if (userBps.isNotEmpty) {
        userBps.sort((a, b) => b.date!.compareTo(a.date!));
        return userBps.first;
      } else {
        // If there are no records, return a default UserBp
        return UserBp(bloodPressure: '', date: null);
      }
    } catch (e) {
      print("Error fetching the last blood pressure record: $e");
      // Handle the error gracefully by returning a default UserBp
      return UserBp(bloodPressure: '', date: null);
    }
  }

  void _showDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _createBloodPressureRecord() async {
    String bloodPressureText = bloodPressureController.text;
    if (bloodPressureText.isEmpty || _selectedDate == null) {
      Fluttertoast.showToast(
        msg: "Please enter both date and blood pressure.",
        toastLength: Toast.LENGTH_SHORT, // Corrected from Toast_SHORT
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    UserBp userBp = UserBp(
      userId: "650a6c285a1bbcfe70b8ad08", // Replace with your actual user ID
      bloodPressure: bloodPressureText, // Pass the entered blood pressure value
      date: _selectedDate,
    );

    try {
      UserBp createdRecord = await UserBpService.createUserBp(userBp);

      if (createdRecord != null) {
        Fluttertoast.showToast(
          msg: "Blood pressure record created successfully.",
          toastLength: Toast.LENGTH_SHORT, // Corrected from Toast_SHORT
          gravity: ToastGravity.BOTTOM,
        );
        bloodPressureController.clear();
        setState(() {
          _selectedDate = null;
        });
      } else {
        Fluttertoast.showToast(
          msg: "Failed to create a blood pressure record.",
          toastLength: Toast.LENGTH_SHORT, // Corrected from Toast_SHORT
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to create a blood pressure record. Error: $e",
        toastLength: Toast.LENGTH_SHORT, // Corrected from Toast_SHORT
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  void _viewRecords() {
    // Navigate to the RecordsPage
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ViewBloodPressurePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Pressure Monitor'),
        backgroundColor: Color.fromARGB(255, 220, 104, 145),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // You can use a different icon if desired
          onPressed: () {
            // Add navigation logic to go to the "Mother Health Tracker" page
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MotherHealthTracker1()), // Replace with your actual page widget
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Box 1 (Existing content)
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What's your reading ?",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 88, 119, 161),
                    ),
                  ),
                  SizedBox(height: 14),
                  Text(
                    "Check your BP regularly at home and ask your healthcare provider what to do if your BP is high. Eat healthy foods and avoid foods that contain high levels of salt, like soup and canned foods which could raise your BP. Staying active for 30 mins a day can help manage your weight, reduce stress, and prevent problems like preeclampsia",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 28),
                  // Use the FutureBuilder to display the last blood pressure record
                  FutureBuilder<UserBp>(
                    future: _getLastBloodPressure(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          "Error: ${snapshot.error}",
                          style: TextStyle(
                            fontSize: 58,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 88, 119, 161),
                          ),
                        );
                      } else {
                        final lastRecord = snapshot.data;
                        if (lastRecord != null) {
                          return Text(
                            "${lastRecord.bloodPressure} mmHg",
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 88, 119, 161),
                            ),
                          );
                        } else {
                          return Text(
                            "0/0",
                            style: TextStyle(
                              fontSize: 58,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 88, 119, 161),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),

            // Box 2 (Input field to enter blood pressure and date)
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(24.0, 18.0, 24.0, 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  TextFormField(
                    controller: bloodPressureController,
                    inputFormatters: [
                      BloodPressureInputFormatter(), // Custom input formatter
                    ],
                    decoration: InputDecoration(
                      labelText: 'Blood Pressure (mmHg)',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextFormField(
                    readOnly: true,
                    onTap: _showDatePicker,
                    decoration: InputDecoration(
                      labelText: 'Date',
                      labelStyle: TextStyle(color: Colors.black),
                      suffixIcon: Icon(Icons.calendar_today, color: Colors.black),
                    ),
                    controller: TextEditingController(
                      text: _selectedDate != null
                          ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
                          : "",
                    ),
                  ),
                ],
              ),
            ),

            // Buttons
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _viewRecords,
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 88, 119, 161),
                        padding: EdgeInsets.all(18),
                      ),
                      child: Text(
                        'View Records',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: ElevatedButton(
                      onPressed: _createBloodPressureRecord,
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 220, 104, 145),
                        padding: EdgeInsets.all(18),
                      ),
                      child: Text(
                        'Add Record',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BloodPressureInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    if (text.length <= 3) {
      return newValue.copyWith(
        text: text,
      );
    } else if (text.length == 4) {
      return newValue.copyWith(
        text: text.substring(0, 3) + '/' + text.substring(3),
        selection: TextSelection.collapsed(offset: text.length + 1),
      );
    } else if (text.length > 4 && text.length <= 7) {
      return newValue.copyWith(
        text: text,
      );
    } else {
      return oldValue;
    }
  }
}
