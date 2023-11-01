import 'package:flutter/material.dart';
import 'package:thurula/services/naps_service.dart';
import 'package:thurula/models/naptimes_model.dart';
import 'package:thurula/views/childcare/nap/nap_timer.dart';
import 'package:intl/intl.dart';

class NapRecords extends StatefulWidget {
  @override
  _NapRecordsState createState() => _NapRecordsState();
}

class _NapRecordsState extends State<NapRecords> {
  Future<List<NapTimes>>? _napRecordsFuture;
  List<NapTimes> napRecords = [];

  @override
  void initState() {
    super.initState();
    _napRecordsFuture = NapService.getBabyNaps('64b01605b55b765169e1c9b6');
  }

  String _formatDuration(int durationInSeconds) {
    final int hours = durationInSeconds ~/ 3600;
    final int minutes = (durationInSeconds % 3600) ~/ 60;
    final int seconds = durationInSeconds % 60;
    return '$hours hrs $minutes mins ';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nap Records'),
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
            napRecords.sort((a, b) => b.startTime!.compareTo(a.startTime!));

            return ListView.builder(
              itemCount: napRecords.length,
              itemBuilder: (context, index) {
                NapTimes record = napRecords[index];
                int durationSeconds =
                    record.endTime!.difference(record.startTime!).inSeconds;
                String formattedDuration = _formatDuration(durationSeconds);

                // Check if it's a new date, and add a date title with a divider.
                if (index == 0 ||
                    DateFormat('EEEE, d MMMM yyyy').format(record.startTime!) !=
                        DateFormat('EEEE, d MMMM yyyy')
                            .format(napRecords[index - 1].startTime!)) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        color: Colors.black54,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          DateFormat('EEEE, d MMMM yyyy')
                              .format(record.startTime!),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 88, 119, 161),
                          ),
                        ),
                      ),
                      _buildNapRecord(record, formattedDuration),
                    ],
                  );
                } else {
                  return _buildNapRecord(record, formattedDuration);
                }
              },
            );
          }
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NapTimer(),
                ),
              );
            },
            child: Icon(Icons.timer),
            backgroundColor: const Color.fromARGB(255, 220, 104, 145),
          ),
          SizedBox(
            height: 16,
          ),
          FloatingActionButton(
            onPressed: () {
              showAddNapDialog(context);
            },
            child: Icon(Icons.add),
            backgroundColor: const Color.fromARGB(255, 220, 104, 145),
          ),
        ],
      ),
    );
  }

  Widget _buildNapRecord(NapTimes record, String formattedDuration) {
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
              child: Center(
                  child: Icon(Icons.hourglass_empty, color: Colors.blue)),
            ),
            VerticalDivider(color: Colors.black54),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'From:${DateFormat('HH:mm a').format(record.startTime!)} -  To:${DateFormat('HH:mm a').format(record.endTime!)}',
                  ),
                  SizedBox(height: 8),
                  Text('Duration: $formattedDuration'),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              color: Color.fromARGB(255, 88, 119, 161),
              onPressed: () {
                _showEditNapDialog(context, record);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: const Color.fromARGB(206, 185, 2, 2),
              onPressed: () {
                _deleteNapRecord(napRecords, record.id ?? '');
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showAddNapDialog(BuildContext context) async {
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
              // title: Text('Add Nap Record'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: [
                        Text('From: '),
                        Text(DateFormat('hh:mm a , d MMMM yyyy')
                            .format(selectedStartTime.toLocal())),
                        SizedBox(width: 10),
                      ],
                    ),
                    ElevatedButton(
                      child: Text('Select Nap Start Date/Time'),
                      onPressed: () async {
                        DateTime? pickedStartTime = await showDatePicker(
                          context: context,
                          initialDate: selectedStartTime,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedStartTime != null) {
                          TimeOfDay? pickedStartTimeOfDay =
                              await showTimePicker(
                            context: context,
                            initialTime:
                                TimeOfDay.fromDateTime(selectedStartTime),
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
                    ),
                    Row(
                      children: [
                        Text('To: '),
                        Text(DateFormat('hh:mm a , d MMMM yyyy')
                            .format(selectedEndTime.toLocal())),
                        SizedBox(width: 10),
                      ],
                    ),
                    ElevatedButton(
                      child: Text('Select Nap End Date/Time'),
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
                            initialTime:
                                TimeOfDay.fromDateTime(selectedEndTime),
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
                    ),
                    Text(message ?? '',
                        style: TextStyle(
                            color: message == 'Error'
                                ? Colors.red
                                : Colors.green)),
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
                    // Validate the new nap record
                    if (selectedStartTime.isBefore(selectedEndTime)) {
                      newNap.startTime = selectedStartTime;
                      newNap.endTime = selectedEndTime;

                      try {
                        // Save the new nap record to the backend with the same baby ID
                        // Replace '64b01605b55b765169e1c9b6' with your actual baby ID
                        newNap.babyId = '64b01605b55b765169e1c9b6';
                        await NapService.createNap(newNap);

                        // Display a success message
                        message = 'Nap record added successfully!';

                        // Close the dialog
                        Navigator.of(context).pop();

                        // Optionally, you can also refresh the nap record list here if needed.
                      } catch (e) {
                        message = 'Error'; // Display the error message
                      }
                    } else {
                      message = 'Please select valid start and end times.';
                    }

                    setState(() {}); // Trigger a rebuild to update the message
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _showEditNapDialog(
      BuildContext context, NapTimes existingNap) async {
    DateTime selectedStartTime = existingNap.startTime ?? DateTime.now();
    DateTime selectedEndTime = existingNap.endTime ?? DateTime.now();
    String? message;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              // title: Text('Edit Nap Record'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: [
                        Text('From: '),
                        Text(DateFormat('hh:mm a,d MMMM yyyy')
                            .format(selectedStartTime.toLocal())),
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
                          TimeOfDay? pickedStartTimeOfDay =
                              await showTimePicker(
                            context: context,
                            initialTime:
                                TimeOfDay.fromDateTime(selectedStartTime),
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
                      child: Text('Update Nap Start Date/Time'),
                    ),
                    Row(
                      children: [
                        Text('To: '),
                        Text(DateFormat('h:mm a,d MMMM yyyy')
                            .format(selectedEndTime.toLocal())),
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
                            initialTime:
                                TimeOfDay.fromDateTime(selectedEndTime),
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
                      child: Text('Update Nap End Date/Time'),
                    ),
                    Text(message ?? '',
                        style: TextStyle(
                            color: message == 'Error'
                                ? Colors.red
                                : Colors.green)),
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

  Future<void> _deleteNapRecord(List<NapTimes> napRecords, String id) async {
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
                Navigator.of(context)
                    .pop(false); // Return false to indicate cancellation
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context)
                    .pop(true); // Return true to indicate confirmation
              },
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      try {
        await NapService.deleteNap(id);

        setState(() {
          napRecords.removeWhere((record) => record.id == id);
        });
      } catch (e) {
        // Handle any errors here (e.g., display an error message).
        print('Failed to delete nap record: $e');
      }
    }
  }
}
