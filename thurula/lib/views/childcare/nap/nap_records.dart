import 'package:flutter/material.dart';

class NapRecords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    List<NapDataRecord> napRecords = [
      NapDataRecord('1'),
      NapDataRecord('2'),
      NapDataRecord('3'),

    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('All Nap Details'),
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text('Record')),
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('Nap Duration')),
            DataColumn(label: Text('Nap Time')),
            DataColumn(label: Text('Edit')),
            DataColumn(label: Text('Delete')),
          ],
          rows: napRecords.map((record) {
            return DataRow(cells: [
              DataCell(Text(record.title)),
              DataCell(Text('11-04-2022')),
              DataCell(Text('04:30')),
              DataCell(Text('05:00 - 08:00')),
              DataCell(IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditNapRecordPage(record: record),
                    ),
                  );
                },
              )),
              DataCell(IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeleteNapRecordPage(record: record),
                    ),
                  );
                },
              )),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}

class NapDataRecord {
  final String title;

  NapDataRecord(this.title);
}

class EditNapRecordPage extends StatelessWidget {
  final NapDataRecord record;

  EditNapRecordPage({required this.record});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Nap Record'),
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Editing: ${record.title}'),
            // Add editing fields and save
          ],
        ),
      ),
    );
  }
}

class DeleteNapRecordPage extends StatelessWidget {
  final NapDataRecord record;

  DeleteNapRecordPage({required this.record});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Nap Record'),
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Deleting: ${record.title}'),
            // Add delete functionality
          ],
        ),
      ),
    );
  }
}
