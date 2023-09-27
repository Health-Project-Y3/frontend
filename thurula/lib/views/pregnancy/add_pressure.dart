import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: AddPressurePage(),
  ));
}

class AddPressurePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weight Monitor'),
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
                    "What's your reading ?",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 88, 119, 161),
                    ),
                  ),
                  SizedBox(height: 14),
                  Text(
                    "Check your BP regulary at home and ask your healthcare provider what to do if your BP is high.Eat healthy foods and avoid foods that contain high levels of slat, like soup and canned foods which could raise your BP.Staying active for 30 mins a day can help manage your weight, reduce stress and prevent problems like preeclampsia",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 28),
                  Text(
                    "0/0 ",
                    style: TextStyle(
                      fontSize: 58,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 88, 119, 161),
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
                children: [
                  Text(
                    "Enter Measured Reading",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Measured Reading',
                    ),
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
