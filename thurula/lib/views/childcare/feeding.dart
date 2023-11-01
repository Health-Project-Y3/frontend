import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thurula/services/feeding_service.dart';
import 'package:thurula/models/feeding_times_model.dart';

class FeedingRecords extends StatefulWidget {
  @override
  _FeedingRecordsState createState() => _FeedingRecordsState();
}

class _FeedingRecordsState extends State<FeedingRecords> {
  Future<List<FeedingTimes>> _feedingRecordsFuture = Future.value([]);
  List<FeedingTimes> feedingRecords = [];

  @override
  void initState() {
    super.initState();
    _loadFeedingRecords();
  }

  Future<void> _loadFeedingRecords() async {
    try {
      _feedingRecordsFuture =
          FeedingService.getBabyFeedings('64a9cb10ec5c9834ff73fc36');
      final records = await _feedingRecordsFuture;
      print('Loaded ${records.length} feeding records.');
      setState(() {
        feedingRecords = records;
        feedingRecords.sort((a, b) => b.startTime!.compareTo(a.startTime!));
      });
    } catch (e) {
      print('Error loading feeding records: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feeding Records'),
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10),
          CustomCard(
            title1: 'Total Feedings Today',
            title2: '${_calculateTotalFeedingsToday(feedingRecords)}',
          ),
          Expanded(
            child: ListView.builder(
              itemCount: feedingRecords.length,
              itemBuilder: (context, index) {
                FeedingTimes record = feedingRecords[index];
                String formattedStartTime = DateFormat('h:mm a')
                    .format(record.startTime ?? DateTime.now());
                String formattedEndTime = DateFormat('h:mm a')
                    .format(record.endTime ?? DateTime.now());

                // Define a map of feeding types to icons
                final iconMap = {
                  'solid': Icons.baby_changing_station,
                  'rightbreast': Icons.local_drink,
                  // Add more types and icons as needed
                };

                return ListTile(
                  leading: Icon(iconMap[record.feedingType] ?? Icons.error),
                  title: Text('Start Time: $formattedStartTime'),
                  subtitle: Text('End Time: $formattedEndTime'),
                  trailing: Text(' ${record.feedingType}'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddFeedingDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
      ),
    );
  }

  Future<void> showAddFeedingDialog(BuildContext context) async {
    TextEditingController feedingTypeController = TextEditingController();
    DateTime selectedDateTime = DateTime.now();
    String? message;

    await showDialog(
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
                        Text('Date & Time: '),
                        Text(
                          DateFormat('hh:mm a, d MMMM yyyy')
                              .format(selectedDateTime.toLocal()),
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    ElevatedButton(
                      child: Text('Select Feeding Date/Time'),
                      onPressed: () async {
                        DateTime? pickedDateTime = await showDatePicker(
                          context: context,
                          initialDate: selectedDateTime,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDateTime != null) {
                          TimeOfDay? pickedTimeOfDay = await showTimePicker(
                            context: context,
                            initialTime:
                                TimeOfDay.fromDateTime(selectedDateTime),
                          );
                          if (pickedTimeOfDay != null) {
                            setState(() {
                              selectedDateTime = DateTime(pickedDateTime.year, pickedDateTime.month, pickedDateTime.day, pickedTimeOfDay.hour, pickedTimeOfDay.minute,
                              );
                            });
                          }
                        }
                      },
                    ),
                    TextField(
                      controller: feedingTypeController,
                      decoration: InputDecoration(labelText: 'Feeding Type'),
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
                    String feedingType = feedingTypeController.text;

                    if (feedingType.isNotEmpty) {
                      try {
                        // Create a new FeedingTimes object and populate it with the selected data
                        FeedingTimes newFeeding = FeedingTimes(
                          startTime: selectedDateTime,
                          feedingType: feedingType,
                          babyId:
                              '64b01605b55b765169e1c9b6', // Replace with your actual baby ID
                        );

                        // Call your FeedingService to save the feeding record
                        await FeedingService.createFeeding(newFeeding);

                        message = 'Feeding record added successfully!';
                        Navigator.of(context).pop();

                        // Optionally, you can also refresh the feeding record list here if needed.
                      } catch (e) {
                        message = 'Error: $e';
                      }
                    } else {
                      message = 'Please enter a feeding type.';
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

  int _calculateTotalFeedingsToday(List<FeedingTimes> records) {
    DateTime today = DateTime.now();
    return records.where((record) {
      return record.startTime != null &&
          record.startTime!.year == today.year &&
          record.startTime!.month == today.month &&
          record.startTime!.day == today.day;
    }).length;
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
        borderRadius:
            BorderRadius.circular(15.0), // Adjust the border radius as needed
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
                image: AssetImage('assets/images/menu-tiles/feeding.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
