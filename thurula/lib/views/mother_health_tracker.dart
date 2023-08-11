import 'package:flutter/material.dart';





class MotherHealthTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFDC6891),
        title: Text("Mother Health Tracker"),
      ),
      backgroundColor: Color(0xFFFFFFFF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
                image: DecorationImage(
                  image: AssetImage('assets/images/mom.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 16),
            Text(
              "Dushanee Gamage",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5877A1),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DashboardCard(
                  label: "Height",
                  value: "184cm",
                  isBold: true,
                  fontSize: 20,
                ),
                SizedBox(width: 16),
                DashboardCard(
                  label: "Weight",
                  value: "63Kg",
                  isBold: true,
                  fontSize: 20,
                ),
              ],
            ),
            SizedBox(height: 16),
            Center(
              child: Container(
                width: 200,
                child: FullWidthCard(
                  label: "Blood Pressure",
                  value: "88mmHg",
                  isBold: true,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 45),
            FullWidthCard(
              label: "Doctor recommendations",
              value: "You are in good health conditions mummy",
              isBold: true,
              fontSize: 18,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => RecordEntryDialog(),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFDC6891),
                textStyle: TextStyle(color: Colors.white),
              ),
              child: Text('Add Record'),
            ),
          ],
        ),
      ),
    );
  }
}
class DashboardCard extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final double fontSize;

  DashboardCard({required this.label, required this.value, this.isBold = false, this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFFDC6891)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Color(0xFF5877A1),
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: fontSize,
            ),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: Color(0xFF5877A1),
            ),
          ),
        ],
      ),
    );
  }
}

class FullWidthCard extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final double fontSize;

  FullWidthCard({required this.label, required this.value, this.isBold = false, this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFFDC6891)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Color(0xFF5877A1),
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: fontSize,
            ),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: Color(0xFF58CF99),
            ),
          ),
        ],
      ),
    );
  }
}

class RecordEntryDialog extends StatefulWidget {
  @override
  _RecordEntryDialogState createState() => _RecordEntryDialogState();
}

class _RecordEntryDialogState extends State<RecordEntryDialog> {
  final TextEditingController systolicController = TextEditingController();
  final TextEditingController diastolicController = TextEditingController();
  final TextEditingController bloodSugarController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Health Record'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 8),
          Text("Blood Pressure", style: TextStyle(fontSize: 16)),
          Row(
            children: [
              Flexible(
                child: TextField(
                  controller: systolicController,
                  decoration: InputDecoration(
                    labelText: 'Systolic Reading',
                    hintText: 'e.g. 120',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(width: 16),
              Flexible(
                child: TextField(
                  controller: diastolicController,
                  decoration: InputDecoration(
                    labelText: 'Diastolic Reading',
                    hintText: 'e.g. 80',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text("Blood Sugar Level", style: TextStyle(fontSize: 16)),
          TextField(
            controller: bloodSugarController,
            decoration: InputDecoration(
              labelText: 'Blood Sugar Level',
              hintText: 'e.g. 120 mg/dL',
            ),
          ),
          SizedBox(height: 16),
          Text("Height and Weight", style: TextStyle(fontSize: 16)),
          Row(
            children: [
              Flexible(
                child: TextField(
                  controller: heightController,
                  decoration: InputDecoration(
                    labelText: 'Height',
                    hintText: 'e.g. 160 cm',
                  ),
                ),
              ),
              SizedBox(width: 16),
              Flexible(
                child: TextField(
                  controller: weightController,
                  decoration: InputDecoration(
                    labelText: 'Weight',
                    hintText: 'e.g. 65 Kg',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text("Date", style: TextStyle(fontSize: 16)),
          TextField(
            controller: dateController,
            decoration: InputDecoration(
              labelText: 'Date (yyyy-mm-dd)',
              hintText: 'e.g. 2023-08-15',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Add record logic
            Navigator.pop(context);
          },
          child: Text('Add'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
