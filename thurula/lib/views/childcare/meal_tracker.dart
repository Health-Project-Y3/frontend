import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thurula/services/feeding_service.dart';
import 'package:thurula/models/feeding_times_model.dart';

class MealTracker extends StatefulWidget {
  @override
  _MealTrackerState createState() => _MealTrackerState();
}

class _MealTrackerState extends State<MealTracker> {
  List<FeedingTimes> feedingRecords = [];

  @override
  void initState() {
    super.initState();
    _loadFeedingRecords();
  }

  Future<void> _loadFeedingRecords() async {
    try {
      final records = await FeedingService.getBabyFeedings('64a9cb10ec5c9834ff73fc36');
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
        backgroundColor: const Color(0xFFDC6891),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10),
          CustomCard(
            title1: 'Total Feedings Today',
            title2: '3',
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        color: Color.fromARGB(255, 88, 119, 161),
                        onPressed: () {
                          // Handle the Edit button action for this record
                          // You can call a function to edit the record here
                          // _editFeedingRecord(record);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: const Color.fromARGB(206, 185, 2, 2),
                        onPressed: () {
                          // Handle the Delete button action for this record
                          // You can call a function to delete the record here
                          // _deleteFeedingRecord(record);
                        },
                      ),
                    ],
                  ),
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
        backgroundColor: const Color(0xFFDC6891),
      ),
    );
  }


  Future<void> showAddFeedingDialog(BuildContext context) async {
    TextEditingController feedingTypeController = TextEditingController();
    DateTime selectedStartDateTime = DateTime.now();
    DateTime selectedEndDateTime = DateTime.now();
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
                    Text('Start Date & Time'),
                    SizedBox(width: 10),
                    Text(
                      DateFormat('hh:mm a, d M yyyy')
                          .format(selectedStartDateTime.toLocal()),
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      child: Text('Select Start Date/Time'),
                      onPressed: () async {
                        DateTime? pickedDateTime = await showDatePicker(
                          context: context,
                          initialDate: selectedStartDateTime,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDateTime != null) {
                          TimeOfDay? pickedTimeOfDay = await showTimePicker(
                            context: context,
                            initialTime:
                            TimeOfDay.fromDateTime(selectedStartDateTime),
                          );
                          if (pickedTimeOfDay != null) {
                            setState(() {
                              selectedStartDateTime = DateTime(
                                pickedDateTime.year,
                                pickedDateTime.month,
                                pickedDateTime.day,
                                pickedTimeOfDay.hour,
                                pickedTimeOfDay.minute,
                              );
                            });
                          }
                        }
                      },
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('End Date & Time: '),
                        SizedBox(width: 10),
                        Text(
                          DateFormat('hh:mm a, d M yyyy')
                              .format(selectedEndDateTime.toLocal()),
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    ElevatedButton(
                      child: Text('Select End Date/Time'),
                      onPressed: () async {
                        DateTime? pickedDateTime = await showDatePicker(
                          context: context,
                          initialDate: selectedEndDateTime,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDateTime != null) {
                          TimeOfDay? pickedTimeOfDay = await showTimePicker(
                            context: context,
                            initialTime:
                            TimeOfDay.fromDateTime(selectedEndDateTime),
                          );
                          if (pickedTimeOfDay != null) {
                            setState(() {
                              selectedEndDateTime = DateTime(
                                pickedDateTime.year,
                                pickedDateTime.month,
                                pickedDateTime.day,
                                pickedTimeOfDay.hour,
                                pickedTimeOfDay.minute,
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
                        FeedingTimes newFeeding = FeedingTimes();
                        newFeeding.startTime = selectedStartDateTime;
                        newFeeding.endTime = selectedEndDateTime;
                        newFeeding.feedingType = feedingType;
                        newFeeding.babyId = '64b01605b55b765169e1c9b6';


                        // Print the selected values in the terminal
                        print('Start Time: $selectedStartDateTime');
                        print('End Time: $selectedEndDateTime');
                        print('Feeding Type: $feedingType');
                        print('$newFeeding');

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
                      color: const Color(0xFFDC6891), // Change color
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