import 'package:flutter/material.dart';



class WeightMonitorPage extends StatefulWidget {
  @override
  _WeightMonitorPageState createState() => _WeightMonitorPageState();
}

class _WeightMonitorPageState extends State<WeightMonitorPage> {
  DateTime? _selectedDate;

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
                  SizedBox(height: 28),
                  Text(
                    "63.0 Kg",
                    style: TextStyle(
                      fontSize: 58,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 88, 119, 161),
                    ),
                  ),
                  SizedBox(height: 24),
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
              padding: const EdgeInsets.fromLTRB(24.0, 18.0, 24.0, 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Weight (kg/lbs)',
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
