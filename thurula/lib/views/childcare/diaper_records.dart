import 'package:flutter/material.dart';
import 'package:thurula/services/diapers_service.dart';
import 'package:thurula/models/diapertimes_model.dart';
import 'package:intl/intl.dart';

import '../widgets/navbar_widget.dart';

class DiaperRecords extends StatefulWidget {
  @override
  _DiaperRecordsState createState() => _DiaperRecordsState();
}

class _DiaperRecordsState extends State<DiaperRecords> {
  Future<List<DiaperTimes>> _diaperRecordsFuture =
  Future<List<DiaperTimes>>.value([]);
  List<DiaperTimes> diaperRecords = [];

  @override
  void initState() {
    super.initState();
    _loadDiaperRecords();
  }

  Future<void> _loadDiaperRecords() async {
    try {
      _diaperRecordsFuture =
          DiaperService.getBabyDiapers('64b01605b55b765169e1c9b6');
      final records = await _diaperRecordsFuture;
      print('Loaded ${records.length} diaper records.');
      setState(() {
        diaperRecords = records;
        diaperRecords.sort((a, b) => b.time!.compareTo(a.time!));
      });
    } catch (e) {
      print('Error loading diaper records: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diaper Change Monitoring'),
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10),

          CustomCard(
            title1: 'Total Diaper Changes Today',
            title2: '${_calculateTotalDiaperChangesToday(diaperRecords)}',
          ),

          Expanded(
            child: ListView.builder(
              itemCount: diaperRecords.length,
              itemBuilder: (context, index) {
                DiaperTimes record = diaperRecords[index];
                String formattedDate = DateFormat('EEEE, d MMMM y')
                    .format(record.time ?? DateTime.now());
                String formattedTime =
                DateFormat('hh:mm:ss').format(record.time ?? DateTime.now());

                if (index == 0 ||
                    formattedDate !=
                        DateFormat('EEEE, d MMMM y')
                            .format(diaperRecords[index - 1].time!)) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        color: Colors.black54,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          formattedDate,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 88, 119, 161),
                          ),
                        ),
                      ),
                      _buildDiaperRecord(formattedTime, record),
                    ],
                  );
                } else {
                  return _buildDiaperRecord(formattedTime, record);
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddDiaperDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
      ),
      bottomNavigationBar: const CreateBottomNavigationBar(pageIndex: 1),
    );
  }
  Future<void> showAddDiaperDialog(BuildContext context) async {
    final TextEditingController diaperTypeController = TextEditingController();
    DateTime? selectedTime = DateTime.now();
    String? selectedDiaperType; // Store the selected diaper type
    String? message;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          '${selectedTime != null ? DateFormat('h:mm a').format(selectedTime!) : ''}, ' // Time
                              '${selectedTime != null ? DateFormat('d MMMM y').format(selectedTime!) : ''}', // Date
                        ),
                        SizedBox(width: 10),
                      ],
                    ),

                    ElevatedButton(
                      onPressed: () async {
                        selectedTime = await _selectTime(context, selectedTime);
                        setState(() {}); // Update the dialog state
                      },
                      child: Text('Change Date/Time'),
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Diaper Type: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'wet',
                              groupValue: selectedDiaperType,
                              onChanged: (value) {
                                setState(() {
                                  selectedDiaperType = value;
                                });
                              },
                            ),
                            Text('Wet'),
                          ],
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'mixed',
                              groupValue: selectedDiaperType,
                              onChanged: (value) {
                                setState(() {
                                  selectedDiaperType = value;
                                });
                              },
                            ),
                            Text('Mixed'),
                          ],
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'dirty',
                              groupValue: selectedDiaperType,
                              onChanged: (value) {
                                setState(() {
                                  selectedDiaperType = value;
                                });
                              },
                            ),
                            Text('Dirty'),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      message ?? '',
                      style: TextStyle(
                        color: message == 'Error' ? Colors.red : Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Save'),
                  onPressed: () async {
                    final diaperType = selectedDiaperType;

                    if (diaperType != null) {
                      final newDiaper = DiaperTimes(
                        time: selectedTime,
                        diaperType: diaperType,
                        babyId: '64b01605b55b765169e1c9b6',
                      );

                      try {
                        await DiaperService.createDiaper(newDiaper);
                        message = 'Diaper change record added successfully!';
                        Navigator.of(context).pop();
                        _loadDiaperRecords();
                      } catch (e) {
                        print('Error in showAddDiaperDialog: $e');
                      }
                    } else {
                      message = 'Please select a valid diaper type.';
                    }

                    setState(() {}); // Update the dialog state
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }


  Future<void> _showEditDiaperDialog(BuildContext context, DiaperTimes existingDiaper) async {
    DateTime selectedTime = existingDiaper.time ?? DateTime.now();
    DateTime initialSelectedTime = selectedTime; // Store the initial selected time
    String? diaperNotes = existingDiaper.diaperNotes;
    String? selectedDiaperType = existingDiaper.diaperType;
    String? loggedBy = existingDiaper.loggedBy;
    String? message;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            String formattedTime =
            DateFormat('h:mm a').format(selectedTime);
            String formattedDate =
            DateFormat(' d MMMM y').format(selectedTime);

            return AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          '$formattedTime, '
                              '$formattedDate  ',
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        DateTime? pickedTime = await showDatePicker(
                          context: context,
                          initialDate: selectedTime,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedTime != null) {
                          TimeOfDay? pickedTimeOfDay = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(selectedTime),
                          );
                          if (pickedTimeOfDay != null) {
                            setState(() {
                              selectedTime = DateTime(
                                pickedTime.year,
                                pickedTime.month,
                                pickedTime.day,
                                pickedTimeOfDay.hour,
                                pickedTimeOfDay.minute,
                              );
                            });
                          }
                        }
                      },
                      child: Text('Update Date/Time'),
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Diaper Type: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'wet',
                              groupValue: selectedDiaperType,
                              onChanged: (value) {
                                setState(() {
                                  selectedDiaperType = value;
                                });
                              },
                            ),
                            Text('Wet'),
                          ],
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'mixed',
                              groupValue: selectedDiaperType,
                              onChanged: (value) {
                                setState(() {
                                  selectedDiaperType = value;
                                });
                              },
                            ),
                            Text('Mixed'),
                          ],
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'dirty',
                              groupValue: selectedDiaperType,
                              onChanged: (value) {
                                setState(() {
                                  selectedDiaperType = value;
                                });
                              },
                            ),
                            Text('Dirty'),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      message ?? '',
                      style: TextStyle(
                        color: message == 'Error' ? Colors.red : Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'Cancel',
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Save'),
                  onPressed: () async {
                    if (selectedTime != null && selectedDiaperType != null) {
                      try {
                        existingDiaper.time = selectedTime;
                        existingDiaper.diaperNotes = diaperNotes;
                        existingDiaper.diaperType = selectedDiaperType;
                        existingDiaper.loggedBy = loggedBy;

                        await DiaperService.updateDiaper(
                          existingDiaper.id ?? '', existingDiaper,
                        );

                        message = 'Diaper change record updated successfully!';
                        Navigator.of(context).pop();
                        _loadDiaperRecords();
                      } catch (e) {
                        message = 'Error';
                      }
                    } else {
                      message = 'Please select a valid time and diaper type.';
                    }

                    setState(() {});
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }


  Future<void> _deleteDiaperRecord(String id) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this record?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      try {
        await DiaperService.deleteDiaper(id);

        setState(() {
          diaperRecords.removeWhere((record) => record.id == id);
        });
      } catch (e) {
        print('Failed to delete diaper change record: $e');
      }
    }
  }

  int _calculateTotalDiaperChangesToday(List<DiaperTimes> records) {
    DateTime today = DateTime.now();
    DateTime startOfDay = DateTime(today.year, today.month, today.day);
    DateTime endOfDay = DateTime(today.year, today.month, today.day, 23, 59, 59);

    return records.where((record) {
      DateTime recordTime = record.time ?? DateTime.now();
      return recordTime.isAfter(startOfDay) && recordTime.isBefore(endOfDay);
    }).length;
  }


  Widget _buildDiaperRecord(String formattedTime, DiaperTimes record) {
    Icon diaperIcon = Icon(Icons.info_outline);
    Color iconColor = Colors.white70;

    if (record.diaperType == 'wet') {
      diaperIcon = Icon(Icons.water_drop, color: Colors.blue);
      iconColor = Colors.blue;
    } else if (record.diaperType == 'dirty') {
      diaperIcon = Icon(Icons.cloud_off, color: Colors.green);
      iconColor = Colors.yellow;
    } else if (record.diaperType == 'mixed') {
      diaperIcon = Icon(Icons.wb_cloudy, color: Colors.brown);
      iconColor = Colors.brown;
    }

    String formattedTime =
    DateFormat('h:mm a').format(record.time ?? DateTime.now());

    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.lightBlue[50],
              ),
              child: Center(child: diaperIcon),
            ),
            VerticalDivider(color: Colors.black54),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$formattedTime'),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                _showEditDiaperDialog(context, record);
              },
              color: Color.fromARGB(255, 88, 119, 161),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteDiaperRecord(record.id ?? '');
              },
              color: const Color.fromARGB(206, 185, 2, 2),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _validateTextField(
      BuildContext context, String fieldName, String value) async {
    if (value.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$fieldName is required'),
          duration: Duration(seconds: 2),
        ),
      );
      return null;
    }
    return value;
  }

  Future<DateTime?> _selectTime(BuildContext context, DateTime? initialTime) async {
    DateTime? selectedTime = initialTime;DateTime? pickedTime = await showDatePicker(
      context: context,
      initialDate: initialTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedTime != null) {
      TimeOfDay initialTimeOfDay = TimeOfDay.fromDateTime(
        initialTime ?? DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 12, 0),
      );

      TimeOfDay? pickedTimeOfDay = await showTimePicker(
        context: context,
        initialTime: initialTimeOfDay,
      );

      if (pickedTimeOfDay != null) {
        selectedTime = DateTime(
          pickedTime.year,
          pickedTime.month,
          pickedTime.day,
          pickedTimeOfDay.hour,
          pickedTimeOfDay.minute,
        );
      }
    }

    return selectedTime;
  }



}


class CustomCard extends StatelessWidget {
  final String title1;
  final String title2;

  CustomCard({required this.title1, required this.title2});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), // Adjust the border radius as needed
      ),
      elevation: 4, // Adjust the shadow as needed
      margin: EdgeInsets.all(10), // Adjust the margin as needed
      child: Container(
        width: double.infinity, // Card should be full width
        height: 100,
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title1,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10), // Add space between titles
                  Text(
                    title2,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22, // Increase font size
                      color: Color.fromARGB(255, 220, 104, 145), // Change color
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),

            Container(
              width: 70.0, // Adjust the width as needed
              child: Image(
                image: AssetImage('assets/images/menu-tiles/diaper.png'),
              ),
            ),

          ],

        ),

      ),
    );
  }
}