import 'package:flutter/material.dart';

class MotherHealthTracker extends StatelessWidget {
  const MotherHealthTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 220, 104, 145), // Background color of the app bar
        title: const Text(
          "Mother Health Tracker",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255), // Title color
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 255, 255, 255), // Back icon color
          ),
          onPressed: () {
            // Handle back button press here
            Navigator.pop(context); // Navigate back
          },
        ),
      ),

      backgroundColor: Color(0xFFFFFFFF),
      body: Center(
        // single child scroll view
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                  image: DecorationImage(
                    image: AssetImage('assets/images/mom.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 16),
              const Text(
                "Ama Gamage",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5877A1),
                ),
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 16),
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
              const SizedBox(height: 45),
              // padding
              Padding(
                // left and right padding
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FullWidthCard(
                  label: "Doctor recommendations",
                  value: "You are in good health conditions mummy",
                  isBold: true,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => RecordEntryDialog(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDC6891),
                  textStyle: const TextStyle(color: Colors.white),
                ),
                child: const Text('Add Record'),
              ),
            ],
          ),
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

  const DashboardCard({super.key, required this.label, required this.value, this.isBold = false, this.fontSize = 14});

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
              color: const Color(0xFF5877A1),
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: fontSize,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
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
              color: const Color(0xFF5877A1),
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: fontSize,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF58CF99),
            ),
          ),
        ],
      ),
    );
  }
}

class RecordEntryDialog extends StatefulWidget {
  const RecordEntryDialog({super.key});

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
      title: const Text('Add Health Record'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            const Text("Blood Pressure", style: TextStyle(fontSize: 16)),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: systolicController,
                    decoration: const InputDecoration(
                      labelText: 'Systolic Reading',
                      hintText: 'e.g. 120',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: TextField(
                    controller: diastolicController,
                    decoration: const InputDecoration(
                      labelText: 'Diastolic Reading',
                      hintText: 'e.g. 80',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text("Blood Sugar Level", style: TextStyle(fontSize: 16)),
            TextField(
              controller: bloodSugarController,
              decoration: const InputDecoration(
                labelText: 'Blood Sugar Level',
                hintText: 'e.g. 120 mg/dL',
              ),
            ),
            const SizedBox(height: 16),
            const Text("Height and Weight", style: TextStyle(fontSize: 16)),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: heightController,
                    decoration: const InputDecoration(
                      labelText: 'Height',
                      hintText: 'e.g. 160 cm',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: TextField(
                    controller: weightController,
                    decoration: const InputDecoration(
                      labelText: 'Weight',
                      hintText: 'e.g. 65 Kg',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text("Date", style: TextStyle(fontSize: 16)),
            TextField(
              controller: dateController,
              decoration: const InputDecoration(
                labelText: 'Date (yyyy-mm-dd)',
                hintText: 'e.g. 2023-08-15',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Add record logic
            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
