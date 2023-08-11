import 'package:flutter/material.dart';

class DiaperChange extends StatefulWidget {
  @override
  _DiaperChange createState() => _DiaperChange();
}

class _DiaperChange extends State<DiaperChange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diaper Change Input'),
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
      ),
      body: SingleChildScrollView(
        // Wrap the Column with SingleChildScrollView
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    'assets/images/menu-icons/diaper.png'), // Replace with your circular image asset
              ),
            ),
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: DiaperChangeEntryForm(),
              ),
            ),
            SizedBox(height: 16),
            Card(
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
          decoration: InputDecoration(
            labelText: 'Date (yyyy-mm-dd)',
            labelStyle: TextStyle(color: Colors.grey), // Adjust the color
          ),
        ),
        TextField(
          controller: _timeController,
          decoration: InputDecoration(
            labelText: 'Time (hh:mm)',
            labelStyle: TextStyle(color: Colors.grey), // Adjust the color
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // Handle button press
          },
          style: ElevatedButton.styleFrom(
            primary:
                const Color.fromARGB(255, 220, 104, 145), // Adjust the color
          ),
          child: Text('Add Diaper Change'),
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
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              color: Colors.blue, // Replace with your desired color
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  'Diaper Change Details',
                  style: TextStyle(
                    color: Colors.white, // Text color for the header
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          DataTable(
            headingRowHeight: 80, // Adjust the header row height as needed
            columns: [
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
                DataCell(Text('09:00')),
                DataCell(Text('2023-08-10')),
                DataCell(IconButton(icon: Icon(Icons.edit), onPressed: () {})),
                DataCell(
                    IconButton(icon: Icon(Icons.delete), onPressed: () {})),
              ]),
              DataRow(cells: [
                DataCell(Text('13:30')),
                DataCell(Text('2023-08-10')),
                DataCell(IconButton(icon: Icon(Icons.edit), onPressed: () {})),
                DataCell(
                    IconButton(icon: Icon(Icons.delete), onPressed: () {})),
              ]),
              DataRow(cells: [
                DataCell(Text('10:45')),
                DataCell(Text('2023-08-11')),
                DataCell(IconButton(icon: Icon(Icons.edit), onPressed: () {})),
                DataCell(
                    IconButton(icon: Icon(Icons.delete), onPressed: () {})),
              ]),
              // ... add more rows
            ],
          ),
        ],
      ),
    );
  }
}
