import 'package:flutter/material.dart';
import 'package:thurula/services/diapers_service.dart';
import 'package:thurula/models/diapertimes_model.dart';
import 'package:intl/intl.dart';

class DiaperRecords extends StatefulWidget {
  @override
  _DiaperRecordsState createState() => _DiaperRecordsState();
}

class _DiaperRecordsState extends State<DiaperRecords> {
  Future<List<DiaperTimes>> _diaperRecordsFuture = Future<List<DiaperTimes>>.value([]);
  List<DiaperTimes> diaperRecords = [];

  @override
  void initState() {
    super.initState();
    _loadDiaperRecords();
  }

  Future<void> _loadDiaperRecords() async {
    try {
      _diaperRecordsFuture = DiaperService.getBabyDiapers('64b01605b55b765169e1c9b6');
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
        title: Text('Diaper Change Details'),
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
      ),
      body: ListView.builder(
        itemCount: diaperRecords.length,
        itemBuilder: (context, index) {
          DiaperTimes record = diaperRecords[index];
          String formattedDate = DateFormat('EEEE, d MMMM y').format(record.time ?? DateTime.now());
          String formattedTime = DateFormat('HH:mm:ss').format(record.time ?? DateTime.now());

          if (index == 0 || formattedDate != DateFormat('EEEE, d MMMM y').format(diaperRecords[index - 1].time!)) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    formattedDate,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ),
                Divider(),
                _buildDiaperRecord(formattedTime, record),
              ],
            );
          } else {
            return _buildDiaperRecord(formattedTime, record);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddDiaperDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
      ),
    );
  }

  Widget _buildDiaperRecord(String formattedTime, DiaperTimes record) {
    Icon diaperIcon = Icon(Icons.info_outline);
    Color iconColor = Colors.grey;

    if (record.diaperType == 'wet') {
      diaperIcon = Icon(Icons.water_drop, color: Colors.blue);
      iconColor = Colors.blue;
    } else if (record.diaperType == 'dirty') {
      diaperIcon = Icon(Icons.cloud_off, color: Colors.green);
      iconColor = Colors.green;
    } else if (record.diaperType == 'mixed') {
      diaperIcon = Icon(Icons.wb_cloudy, color: Colors.brown);
      iconColor = Colors.brown;
    }

    String formattedTime = DateFormat('h:mm a').format(record.time ?? DateTime.now());

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
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
              child: Center(child: diaperIcon),
            ),
            VerticalDivider(color: Colors.grey),
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
              color: const Color.fromARGB(255, 185, 157, 2),
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

  Future<void> showAddDiaperDialog(BuildContext context) async {
    final TextEditingController diaperTypeController = TextEditingController();

    DateTime? selectedTime = DateTime.now();
    String? message;

    selectedTime = await _selectTime(context, selectedTime);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Diaper Change Record'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: [
                    Text('Time: '),
                    Text(
                      '${selectedTime?.hour.toString().padLeft(2, '0')}:${selectedTime?.minute.toString().padLeft(2, '0')} ${selectedTime?.day.toString().padLeft(2, '0')}/${selectedTime?.month.toString().padLeft(2, '0')}/${selectedTime?.year}',
                      // style: TextStyle(fontweight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    selectedTime = await _selectTime(context, selectedTime);
                    setState(() {});
                  },
                  child: Text('Select Time'),
                ),

                TextField(
                  controller: diaperTypeController,
                  decoration: InputDecoration(labelText: 'Diaper Type'),
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

                final diaperType = await _validateTextField(context, 'Diaper Type', diaperTypeController.text);


                if (diaperType != null ) {
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
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<String?> _validateTextField(BuildContext context, String fieldName, String value) async {
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
    DateTime? selectedTime = initialTime;

    await showDatePicker(
      context: context,
      initialDate: initialTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ).then((pickedTime) async {
      if (pickedTime != null) {
        final TimeOfDay initialTimeOfDay = TimeOfDay.fromDateTime(
          initialTime ?? DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 12, 0),
        );

        TimeOfDay? pickedTimeOfDay = await showTimePicker(
          context: context,
          initialTime: initialTimeOfDay,
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!,
            );
          },
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
    });

    return selectedTime;
  }

  Future<void> _showEditDiaperDialog(BuildContext context, DiaperTimes existingDiaper) async {
    DateTime selectedTime = existingDiaper.time ?? DateTime.now();
    String? diaperNotes = existingDiaper.diaperNotes;
    String? diaperType = existingDiaper.diaperType;
    String? loggedBy = existingDiaper.loggedBy;
    String? message;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Edit Diaper Change Record'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: [
                        Text('Time: '),
                        Text(
                          '${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}',
                          style: TextStyle(fontWeight: FontWeight.bold),
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
                      child: Text('Select Time'),
                    ),
                    TextFormField(
                      initialValue: diaperNotes,
                      onChanged: (value) {
                        diaperNotes = value;
                      },
                      decoration: InputDecoration(labelText: 'Diaper Notes'),
                    ),
                    TextFormField(
                      initialValue: diaperType,
                      onChanged: (value) {
                        diaperType = value;
                      },
                      decoration: InputDecoration(labelText: 'Diaper Type'),
                    ),
                    TextFormField(
                      initialValue: loggedBy,
                      onChanged: (value) {
                        loggedBy = value;
                      },
                      decoration: InputDecoration(labelText: 'Logged By'),
                    ),
                    Text(
                      message ?? '',
                      style: TextStyle(color: message == 'Error' ? Colors.red : Colors.green),
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
                    if (selectedTime != null) {
                      try {
                        existingDiaper.time = selectedTime;
                        existingDiaper.diaperNotes = diaperNotes;
                        existingDiaper.diaperType = diaperType;
                        existingDiaper.loggedBy = loggedBy;

                        await DiaperService.updateDiaper(existingDiaper.id ?? '', existingDiaper);

                        message = 'Diaper change record updated successfully!';
                        Navigator.of(context).pop();
                        _loadDiaperRecords();
                      } catch (e) {
                        message = 'Error';
                      }
                    } else {
                      message = 'Please select a valid time.';
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
}
