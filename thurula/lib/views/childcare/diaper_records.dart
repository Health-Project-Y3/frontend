import 'package:flutter/material.dart';
import 'package:thurula/services/diapers_service.dart';
import 'package:thurula/models/diapertimes_model.dart';

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


  // Function to load diaper change records
  Future<void> _loadDiaperRecords() async {
    try {
      _diaperRecordsFuture =
          DiaperService.getBabyDiapers('64b01605b55b765169e1c9b6');
      final records = await _diaperRecordsFuture;
      print('Loaded ${records.length} diaper records.');
      setState(() {
        diaperRecords = records;
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
      body: FutureBuilder<List<DiaperTimes>>(
        future: _diaperRecordsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No diaper change records found.'));
          } else {
            // Data has been loaded successfully.
            diaperRecords = snapshot.data!;

            // Create a ListView to display diaper change records
            return ListView.builder(
              itemCount: diaperRecords.length,
              itemBuilder: (context, index) {
                DiaperTimes record = diaperRecords[index];
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Time: ${record.time?.toString() ?? ''}'),
                        SizedBox(height: 8),
                        Text('Notes: ${record.diaperNotes ?? ''}'),
                        SizedBox(height: 8),
                        Text('Type: ${record.diaperType ?? ''}'),
                        SizedBox(height: 8),
                        Text('Logged by: ${record.loggedBy ?? ''}'),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _showEditDiaperDialog(context, record);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _deleteDiaperRecord(record.id ?? '');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
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

  Future<void> showAddDiaperDialog(BuildContext context) async {
    final TextEditingController diaperNotesController = TextEditingController();
    final TextEditingController diaperTypeController = TextEditingController();
    final TextEditingController loggedByController = TextEditingController();
    DateTime? selectedTime = DateTime.now();
    String? message;

    selectedTime = await _selectTime(context, selectedTime ?? DateTime.now());


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
                    Text(selectedTime?.toLocal().toString() ?? 'No time selected'),
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
                  controller: diaperNotesController,
                  decoration: InputDecoration(labelText: 'Diaper Notes'),
                ),
                TextField(
                  controller: diaperTypeController,
                  decoration: InputDecoration(labelText: 'Diaper Type'),
                ),
                TextField(
                  controller: loggedByController,
                  decoration: InputDecoration(labelText: 'Logged By'),
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
                // Read values from the controllers here
                String diaperNotes = diaperNotesController.text;
                String diaperType = diaperTypeController.text;
                String loggedBy = loggedByController.text;

                // Validate the fields
                if (diaperNotes.isNotEmpty && diaperType.isNotEmpty && loggedBy.isNotEmpty) {
                  final newDiaper = DiaperTimes(
                    time: selectedTime,
                    diaperNotes: diaperNotes,
                    diaperType: diaperType,
                    loggedBy: loggedBy,
                    babyId: '64b01605b55b765169e1c9b6',
                  );



                  try {
                    await DiaperService.createDiaper(newDiaper);

                    message = 'Diaper change record added successfully!';
                    Navigator.of(context).pop(); // Close the dialog
                    _loadDiaperRecords(); // Refresh the diaper change record list
                  } catch (e) {
                    print('Error in _showAddDiaperDialog: $e');
                  }
                } else {
                  setState(() {
                    message = 'All fields are required.';
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }



  Future<String?> _validateTextField(
      BuildContext context,
      String fieldName,
      String value,
      ) async {
    if (value.isEmpty) {
      // Display an error message for empty input
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$fieldName is required'),
          duration: Duration(seconds: 2),
        ),
      );
      return null;
    }
    // Additional validation logic can be added here if needed
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
        TimeOfDay? pickedTimeOfDay = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(initialTime ?? DateTime.now()),
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
                        Text(selectedTime.toLocal().toString()),
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
                            initialTime:
                            TimeOfDay.fromDateTime(selectedTime),
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
                    Text(message ?? '',
                        style: TextStyle(
                            color:
                            message == 'Error' ? Colors.red : Colors.green)),
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
                        await DiaperService.updateDiaper(
                            existingDiaper.id ?? '', existingDiaper);

                        message = 'Diaper change record updated successfully!';
                        Navigator.of(context).pop(); // Close the dialog
                        _loadDiaperRecords(); // Refresh the diaper change record list
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
