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
    return '$hours hrs $minutes mins $seconds s';
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
                // Calculate the duration in seconds
                int durationSeconds = record.endTime!.difference(record.startTime!).inSeconds;
                // Format the duration in hours, minutes, and seconds
                String formattedDuration = _formatDuration(durationSeconds);
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Date: ${DateFormat('yyyy-MM-dd').format(record.startTime!)}'),
                              SizedBox(height: 8),
                              Text('Start Time: ${DateFormat('HH:mm:ss').format(record.startTime!)}'),
                              SizedBox(height: 8),
                              Text('End Time: ${DateFormat('HH:mm:ss').format(record.endTime!)}'),
                              SizedBox(height: 8),
                              Text('Duration: $formattedDuration'),
                              // Display the formatted duration
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _showEditNapDialog(context, record);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteNapRecord(napRecords, record.id ?? '');
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
            child: Icon(Icons.timer), // Change the icon to stopwatch or timer
            backgroundColor: const Color.fromARGB(255, 220, 104, 145),
          ),
          SizedBox(height: 16), // Add some spacing between the FloatingActionButton
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
              title: Text('Add Nap Record'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: [
                        Text('Start Time: '),
                        Text(DateFormat('HH:mm:ss').format(selectedStartTime.toLocal())),
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
                        Text(DateFormat('HH:mm:ss').format(selectedEndTime.toLocal())),
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

                    Text(message ?? '', style: TextStyle(
                        color: message == 'Error' ? Colors.red : Colors.green)),
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
                        Text(DateFormat('HH:mm:ss').format(selectedStartTime.toLocal())),
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
                        Text(DateFormat('HH:mm:ss').format(selectedEndTime.toLocal())),
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
                    Text(message ?? '', style: TextStyle(
                        color: message == 'Error' ? Colors.red : Colors.green)),
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
                Navigator.of(context).pop(
                    false); // Return false to indicate cancellation
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(
                    true); // Return true to indicate confirmation
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


