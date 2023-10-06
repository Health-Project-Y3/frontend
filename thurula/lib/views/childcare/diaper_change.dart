import 'package:flutter/material.dart';

class DiaperChange extends StatefulWidget {
  const DiaperChange({super.key});

  @override
  _DiaperChange createState() => _DiaperChange();
}

class _DiaperChange extends State<DiaperChange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Diaper Change',
          style: TextStyle(
            color: Colors.white, // Title color
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white, // Back icon color
          ),
          onPressed: () {
            // Handle back button press here
            Navigator.pop(context); // Navigate back
          },
        ),
      ),



      body: SingleChildScrollView(
        // Wrap the Column with SingleChildScrollView
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              child: const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    'assets/images/menu-icons/diaper.png'), // Replace with your circular image asset
              ),
            ),
            const Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: DiaperChangeEntryForm(),
              ),
            ),
            const SizedBox(height: 16),
            const Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: DiaperChangeDetails(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DiaperChangeEntryForm extends StatefulWidget {
  const DiaperChangeEntryForm({super.key});

  @override
  _DiaperChangeEntryFormState createState() => _DiaperChangeEntryFormState();
}

class _DiaperChangeEntryFormState extends State<DiaperChangeEntryForm> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _dateController,
          decoration: const InputDecoration(
            labelText: 'Date (yyyy-mm-dd)',
            labelStyle: TextStyle(color: Colors.grey), // Adjust the color
          ),
        ),
        TextField(
          controller: _timeController,
          decoration: const InputDecoration(
            labelText: 'Time (hh:mm)',
            labelStyle: TextStyle(color: Colors.grey), // Adjust the color
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // Handle button press
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 220, 104, 145),
          ),
          child: const Text('Add Diaper Change'),
        ),
      ],
    );
  }
}

class DiaperChangeEntry {
  final DateTime dateTime;

  DiaperChangeEntry(this.dateTime);
}

class DiaperChangeDetails extends StatelessWidget {
  const DiaperChangeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Stack(
        children: [
          Positioned(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: const Center(
                child: Text(
                  'Diaper Change Details',
                  style: TextStyle(
                    color: Color.fromARGB(255, 220, 104, 145), // Text color for the header
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          DataTable(
            dividerThickness: 0,
            headingRowHeight: 60, // Adjust the header row height as needed
            columns: const [
              DataColumn(
                label: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text('Time'),
                ),
              ),
              DataColumn(
                label: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text('Date'),
                ),
              ),
              DataColumn(
                label: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text('Edit'),
                ),
              ),
              DataColumn(
                label: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text('Delete'),
                ),
              ),
            ],
            rows: [
              DataRow(cells: [
                const DataCell(Text('09:00')),
                const DataCell(Text('2023-08-10')),
                DataCell(
                    SizedBox(
                      width: 30, // Adjust the width as needed
                      child: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                        },
                      ),
                    ),
                ),
                //
                DataCell(
                    SizedBox(
                      width: 20, // Adjust the width as needed
                      child: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    ),
                ),
              ]),
              DataRow(cells: [
                const DataCell(Text('13:30')),
                const DataCell(Text('2023-08-10')),
                DataCell(
                SizedBox(
                      width: 30, // Adjust the width as needed
                      child: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {},
                      ),
                    ),
                ),
                DataCell(
                    SizedBox(
                      width: 20, // Adjust the width as needed
                      child: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    ),
                ),
              ]),
              DataRow(cells: [
                const DataCell(Text('10:45')),
                const DataCell(Text('2023-08-11')),
                DataCell(
                SizedBox(
                      width: 30, // Adjust the width as needed
                      child: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {},
                      ),
                    ),
                ),
                DataCell(
                    SizedBox(
                      width: 20, // Adjust the width as needed
                      child: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    ),
                ),
              ]),
              // ... add more rows
            ],
          ),
        ],
      ),
    );
  }
}
