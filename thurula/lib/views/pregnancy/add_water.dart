import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home:WaterMonitorPage(),
  ));
}

class WaterMonitorPage extends StatefulWidget {
  @override
  _WaterMonitorPageState createState() => _WaterMonitorPageState();
}

class _WaterMonitorPageState extends State<WaterMonitorPage> {
  String? _selectedOption; // To store the selected dropdown option

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Water Intake'),
        backgroundColor: Color.fromARGB(255, 220, 104, 145),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Box 1
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
              "How Much Water Do You Need?",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 88, 119, 161),
                    ),
                  ),
                  SizedBox(height: 14),
                  Text(
                    "During pregnancy, your body has increased demands, and one crucial aspect is staying well-hydrated. Just like your growing baby needs extra calories, it also requires extra fluids to support its development. While every pregnancy is unique, here's a general guideline to help you maintain optimal hydration",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 28),
                  Text(
                    "5 Glasses",
                    style: TextStyle(
                      fontSize: 58,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 88, 119, 161),
                    ),
                  ),
                  SizedBox(height: 28),
                  Text(
                    "Gained in the last week 5kg",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),


            // Box 2 (Input field to enter weight)
            Container(
              height: MediaQuery.of(context).size.height * 0.2, // Adjust the height here
              color: Colors.white,
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [SizedBox(height: 8),

              DropdownButtonFormField<String>(
                value: _selectedOption,
                onChanged: (newValue) {
                  setState(() {
                    _selectedOption = newValue;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Select Option',
                ),
                items: [
                  DropdownMenuItem<String>(
                    value: '1 Glass (240ml)',
                    child: Text('1 Glass (240ml)'),
                  ),
                  DropdownMenuItem<String>(
                    value: '2 Glass (480ml)',
                    child: Text('2 Glass (480ml)'),
                  ),
                  DropdownMenuItem<String>(
                    value: '3 Glass (720ml)',
                    child: Text('3 Glass (720ml)'),
                  ),
                  DropdownMenuItem<String>(
                    value: '1 Liter (1000ml)',
                    child: Text('1 Liter (1000ml)'),
                  ),
                  DropdownMenuItem<String>(
                    value: '2 Liters (2000ml)',
                    child: Text('2 Liters (2000ml)'),
                  ),
                  DropdownMenuItem<String>(
                    value: '3 Liters (3000ml)',
                    child: Text('3 Liters (3000ml)'),
                  ),
                ],
              ),
                ],
              ),
            ),



// Button
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  // Handle update button logic here
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 220, 104, 145),
                  padding: EdgeInsets.all(18),
                ),
                child: Text(
                  'Update',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
