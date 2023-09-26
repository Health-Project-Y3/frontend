import 'package:flutter/material.dart';
import 'package:thurula/services/diapers_service.dart';
import 'package:thurula/models/diapertimes_model.dart';

class DiaperChange extends StatefulWidget {
  @override
  _DiaperChangeState createState() => _DiaperChangeState();
}

class _DiaperChangeState extends State<DiaperChange> {
  Future<List<DiaperTimes>>? _diaperRecordsFuture;
  List<DiaperTimes> diaperRecords = [];
  DateTime? newDateTime; // Added for selecting date and time

  @override
  void initState() {
    super.initState();
    _diaperRecordsFuture = DiaperService.getBabyDiapers('64b01605b55b765169e1c9b6');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diaper Change'),
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
                        Text('Diaper Type: ${record.diaperType ?? ''}'),
                        SizedBox(height: 8),
                        Text('Diaper Notes: ${record.diaperNotes ?? ''}'),
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
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDiaperDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
      ),
    );
  }

  Future<void> _showAddDiaperDialog(BuildContext context) async {
    TextEditingController diaperNotesController = TextEditingController();
    String selectedDiaperType = 'Nothing';
    DateTime? selectedDateTime = DateTime.now();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add Diaper Record'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    InkWell(
                      onTap: () => _selectDateTime(context),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Date and Time',
                          labelStyle: TextStyle(color: Colors.grey),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              selectedDateTime != null
                                  ? "${selectedDateTime.toLocal()}".split(' ')[0]
                                  : "Select Date and Time",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              selectedDateTime != null
                                  ? "${selectedDateTime.toLocal()}".split(' ')[1]
                                  : "",
                              style: TextStyle(fontSize: 16),
                            ),
                            Icon(
                              Icons.calendar_today,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                    InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Diaper Type',
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: selectedDiaperType,
                        onChanged: (newValue) {
                          setState(() {
                            selectedDiaperType = newValue!;
                          });
                        },
                        items: ['Wet', 'Dry', 'Nothing'].map((type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                      ),
                    ),
                    TextField(
                      controller: diaperNotesController,
                      decoration: InputDecoration(labelText: 'Diaper Notes'),
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
                    if (selectedDateTime == null ||
                        selectedDiaperType == null ||
                        selectedDiaperType.isEmpty) {
                      // Display an error message or prevent submission
                      return;
                    }

                    final newRecord = DiaperTimes(
                      diaperNotes: diaperNotesController.text,
                      diaperType: selectedDiaperType,
                      time: selectedDateTime,
                    );

                    try {
                      final DiaperTimes? addedRecord =
                      await DiaperService.createDiaper(newRecord);

                      if (addedRecord != null) {
                        setState(() {
                          diaperRecords.add(addedRecord);
                        });

                        // Close the dialog
                        Navigator.of(context).pop();
                      } else {
                        print('Failed to add diaper record: Unexpected API response');
                      }
                    } catch (e) {
                      print('Failed to add diaper record: $e');
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Define the edit diaper dialog here
  void _showEditDiaperDialog(BuildContext context, DiaperTimes record) {
    // Implement your edit diaper dialog logic here
  }

  void _deleteDiaperRecord(String id) async {
    try {
      await DiaperService.deleteDiaper(id);
      setState(() {
        diaperRecords.removeWhere((record) => record.id == id);
      });
    } catch (e) {
      print('Failed to delete diaper record: $e');
    }
  }

  void _selectDateTime(BuildContext context) async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: newDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDateTime != null) {
      final TimeOfDay? pickedTimeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(newDateTime ?? DateTime.now()),
      );

      if (pickedTimeOfDay != null) {
        setState(() {
          newDateTime = DateTime(
            pickedDateTime.year,
            pickedDateTime.month,
            pickedDateTime.day,
            pickedTimeOfDay.hour,
            pickedTimeOfDay.minute,
          );
        });
      }
    }
  }
}
