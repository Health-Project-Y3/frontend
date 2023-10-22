import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thurula/services/auth/user_service.dart';
import 'package:thurula/models/user_model.dart';
import 'package:thurula/models/user_weight_model.dart';
import 'package:thurula/services/user_weight_service.dart';
import 'package:thurula/views/pregnancy/view_weight_records.dart';

class WeightMonitorPage extends StatefulWidget {
  @override
  _WeightMonitorPageState createState() => _WeightMonitorPageState();
}

class _WeightMonitorPageState extends State<WeightMonitorPage> {
  DateTime _selectedDate = DateTime.now();
  double? _userWeight;
  String? _weightError;
  String? _dateError;
  TextEditingController _weightController = TextEditingController();
  String _tempSelectedDate = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _tempSelectedDate = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}"; // Store date in the format yyyy-MM-dd
        _dateError = null;
      });
    }
  }

  Future<User?> _getUserData() async {
    return UserService.getUser('652a5d43935d40f339c12d8b');
  }

  Future<void> _createUserWeight(UserWeight userWeight) async {
    try {
      if (_tempSelectedDate.isEmpty) {
        setState(() {
          _dateError = "Please select a date";
        });
        return;
      }

      await UserWeightService.createUserWeight(userWeight);
      Fluttertoast.showToast(
        msg: "Weight recorded successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
      );

      setState(() {
        _selectedDate = DateTime.now();
        _tempSelectedDate = '';
        _userWeight = null;
        _weightController.clear();
        _weightError = null;
        _dateError = null;
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: Weight not recorded. Please try again.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        timeInSecForIosWeb: 2,
        fontSize: 16.0,
      );
      print('Error creating user weight: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weight Monitor'),
        backgroundColor: Color.fromARGB(255, 220, 104, 145),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "What does your Scale Say ?",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 88, 119, 161),
                  ),
                ),
                SizedBox(height: 14),
                Text(
                  "You'll need 300 extra calories every day to support your baby's growth and development. Every pregnancy is different, don't worry about gaining too much or too little, stay active and be positive always. All that matters is if your baby is growing well. Talk to your OBYGYN for any concerns.",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 20),
                FutureBuilder<User?>(
                  future: _getUserData(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (userSnapshot.hasData) {
                      final double userWeight = userSnapshot.data!.preWeight ?? 0.0;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${userWeight.toStringAsFixed(1)} Kg",
                            style: TextStyle(
                              fontSize: 58,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 88, 119, 161),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Navigate to AddPressurePage when the button is pressed
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ViewWeightPage(userId: '652a5d43935d40f339c12d8b')),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 88, 119, 161), // Customize the button color as needed
                              minimumSize: Size(120, 0),
                              padding: EdgeInsets.all(16.0),
                            ),
                            child: Text('View Records'),
                          ),
                        ],
                      );
                    } else {
                      return Text('User weight not available');
                    }
                  },
                ),
                SizedBox(height: 10),
                Text(
                  "Gained in the last week 5kg",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(24.0, 18.0, 24.0, 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Weight (kg/lbs)',
                    labelStyle: TextStyle(color: Colors.black),
                    errorText: _weightError,
                  ),
                  controller: _weightController,
                  onChanged: (value) {
                    setState(() {
                      _userWeight = double.tryParse(value);
                      _weightError = null;
                    });
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Date',
                    labelStyle: TextStyle(color: Colors.black),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Icon(Icons.calendar_today, color: Colors.black),
                    ),
                    errorText: _dateError,
                  ),
                  readOnly: true,
                  controller: TextEditingController(text: _tempSelectedDate),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () async {
                    // Clear the previous data before validation
                    setState(() {
                      _weightError = null;
                      _dateError = null;
                    });

                    if (_userWeight == null) {
                      setState(() {
                        _weightError = "Please add weight";
                      });
                    }

                    if (_tempSelectedDate.isEmpty) {
                      setState(() {
                        _dateError = "Please select a date";
                      });
                    }

                    if (_userWeight != null && _tempSelectedDate.isNotEmpty) {
                      final userWeight = UserWeight(
                        userId: '652a5d43935d40f339c12d8b',
                        weight: _userWeight,
                        date: DateTime.parse(_tempSelectedDate), // Use the selected date stored in _tempSelectedDate
                      );
                      await _createUserWeight(userWeight);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 220, 104, 145),
                    minimumSize: Size(
                      double.infinity,
                      0.0,
                    ),
                    padding: EdgeInsets.all(16.0),
                  ),
                  child: Text('Add Record'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
