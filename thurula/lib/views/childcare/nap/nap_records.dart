import 'package:flutter/material.dart';
import 'package:thurula/services/naps_service.dart';
import 'package:thurula/models/naptimes_model.dart';

class NapRecords extends StatefulWidget {
  @override
  _NapRecordsState createState() => _NapRecordsState();
}

class _NapRecordsState extends State<NapRecords> {
  Future<List<NapTimes>>? _napRecordsFuture;
  List<NapTimes> napRecords = []; // List to hold nap records

  @override
  void initState() {
    super.initState();
    _napRecordsFuture = NapService.getBabyNaps('64b01605b55b765169e1c9b6');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Nap Details'),
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
      ),
      body: FutureBuilder<List<NapTimes>>(
        future: _napRecordsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No nap records found.'));
          } else {
            // Data has been loaded successfully.
            napRecords = snapshot.data!;

            // Create a ListView to display nap records in a vertical timeline format
            return ListView.builder(
              itemCount: napRecords.length,
              itemBuilder: (context, index) {
                NapTimes record = napRecords[index];
                // Calculate the duration in minutes
                int durationSeconds = (record.endTime!.difference(record.startTime!)).inSeconds;
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Start: ${record.startTime?.toString() ?? ''}'),
                        SizedBox(height: 8),
                        Text('End: ${record.endTime?.toString() ?? ''}'),
                        SizedBox(height: 8),
                        Text('Duration: $durationSeconds seconds'), // Display the calculated duration
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _showEditNapDialog(context, record);
                              },
                            ),

                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // Implement delete functionality here
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
          _showAddNapDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
      ),
    );
  }

  Future<void> _showAddNapDialog(BuildContext context) async {
    NapTimes newNap = NapTimes(); // Create a new empty NapTimes object
    DateTime selectedStartTime = DateTime.now();
    DateTime selectedEndTime = DateTime.now();
    String? message;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add Nap Record'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: [
                        Text('Start Time: '),
                        Text(selectedStartTime.toLocal().toString()),
                        SizedBox(width: 10),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        DateTime? pickedStartTime = await showDatePicker(
                          context: context,
                          initialDate: selectedStartTime,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedStartTime != null) {
                          TimeOfDay? pickedStartTimeOfDay = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(selectedStartTime),
                          );
                          if (pickedStartTimeOfDay != null) {
                            setState(() {
                              selectedStartTime = DateTime(
                                pickedStartTime.year,
                                pickedStartTime.month,
                                pickedStartTime.day,
                                pickedStartTimeOfDay.hour,
                                pickedStartTimeOfDay.minute,
                              );
                              newNap.startTime = selectedStartTime;
                            });
                          }
                        }
                      },
                      child: Text('Select Start Time'),
                    ),
                    Row(
                      children: [
                        Text('End Time: '),
                        Text(selectedEndTime.toLocal().toString()),
                        SizedBox(width: 10),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        DateTime? pickedEndTime = await showDatePicker(
                          context: context,
                          initialDate: selectedEndTime,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedEndTime != null) {
                          TimeOfDay? pickedEndTimeOfDay = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(selectedEndTime),
                          );
                          if (pickedEndTimeOfDay != null) {
                            setState(() {
                              selectedEndTime = DateTime(
                                pickedEndTime.year,
                                pickedEndTime.month,
                                pickedEndTime.day,
                                pickedEndTimeOfDay.hour,
                                pickedEndTimeOfDay.minute,
                              );
                              newNap.endTime = selectedEndTime;
                            });
                          }
                        }
                      },
                      child: Text('Select End Time'),
                    ),
                    Text(message ?? '', style: TextStyle(color: message == 'Error' ? Colors.red : Colors.green)), // Display success or error message
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
                    // Validate and save the new nap record
                    if (newNap.startTime != null && newNap.endTime != null) {
                      try {
                        // Create the nap record and get the response
                        NapTimes addedNap = await NapService.createNap(newNap);

                        // Add the newly created record to the existing list
                        setState(() {
                          napRecords.add(addedNap);
                        });

                        // Display a success message
                        message = 'Nap record added successfully!';

                        // Close the dialog
                        Navigator.of(context).pop();

                      } catch (e) {
                        message = 'Error'; // Display the error message
                      }
                    } else {
                      message = 'Please select valid start and end times.';
                    }

                    setState(() {}); // Refresh the dialog to show the message
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}

Future<void> _showEditNapDialog(BuildContext context, NapTimes existingNap) async {
  DateTime selectedStartTime = existingNap.startTime ?? DateTime.now();
  DateTime selectedEndTime = existingNap.endTime ?? DateTime.now();
  String? message;

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Edit Nap Record'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: [
                      Text('Start Time: '),
                      Text(selectedStartTime.toLocal().toString()),
                      SizedBox(width: 10),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? pickedStartTime = await showDatePicker(
                        context: context,
                        initialDate: selectedStartTime,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedStartTime != null) {
                        TimeOfDay? pickedStartTimeOfDay = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(selectedStartTime),
                        );
                        if (pickedStartTimeOfDay != null) {
                          setState(() {
                            selectedStartTime = DateTime(
                              pickedStartTime.year,
                              pickedStartTime.month,
                              pickedStartTime.day,
                              pickedStartTimeOfDay.hour,
                              pickedStartTimeOfDay.minute,
                            );
                          });
                        }
                      }
                    },
                    child: Text('Select Start Time'),
                  ),
                  Row(
                    children: [
                      Text('End Time: '),
                      Text(selectedEndTime.toLocal().toString()),
                      SizedBox(width: 10),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? pickedEndTime = await showDatePicker(
                        context: context,
                        initialDate: selectedEndTime,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedEndTime != null) {
                        TimeOfDay? pickedEndTimeOfDay = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(selectedEndTime),
                        );
                        if (pickedEndTimeOfDay != null) {
                          setState(() {
                            selectedEndTime = DateTime(
                              pickedEndTime.year,
                              pickedEndTime.month,
                              pickedEndTime.day,
                              pickedEndTimeOfDay.hour,
                              pickedEndTimeOfDay.minute,
                            );
                          });
                        }
                      }
                    },
                    child: Text('Select End Time'),
                  ),
                  Text(message ?? '', style: TextStyle(color: message == 'Error' ? Colors.red : Colors.green)),
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
                  if (selectedStartTime != null && selectedEndTime != null) {
                    try {
                      // Update the nap record and get the response
                      existingNap.startTime = selectedStartTime;
                      existingNap.endTime = selectedEndTime;
                      await NapService.updateNap(existingNap);

                      message = 'Nap record updated successfully!';
                      Navigator.of(context).pop(); // Close the dialog

                    } catch (e) {
                      message = 'Error';
                    }
                  } else {
                    message = 'Please select valid start and end times.';
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

