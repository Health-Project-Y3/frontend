import 'package:flutter/material.dart';
import 'package:thurula/services/feeding_service.dart';
import 'package:thurula/models/feeding_times_model.dart';
import 'package:intl/intl.dart';

class MealTracker extends StatefulWidget {
  MealTracker({Key? key}) : super(key: key);

  @override
  _MealTrackerState createState() => _MealTrackerState();
}

class _MealTrackerState extends State<MealTracker> {
  Future<List<FeedingTimes>> _mealRecordsFuture = Future.value([]);
  List<FeedingTimes> mealRecords = [];

  @override
  void initState() {
    super.initState();
    _mealRecordsFuture = FeedingService.getBabyFeedings(
        '64a9cb10ec5c9834ff73fc36'); // Replace with your actual baby ID
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Baby Meal Tracker',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          _buildFeedingTypeButtons(), // Add feeding type buttons
          Expanded(
            child: FutureBuilder<List<FeedingTimes>>(
              future: _mealRecordsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No meal records found.'));
                } else {
                  mealRecords = snapshot.data!;
                  return ListView.builder(
                    itemCount: mealRecords.length,
                    itemBuilder: (context, index) {
                      FeedingTimes record = mealRecords[index];
                      return ListTile(
                        title: Text(record.feedingType ?? ''),
                        subtitle: Text(DateFormat('hh:mm a dd-MM-yyyy')
                            .format(record.startTime ?? DateTime.now())),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit,
                                  color: Color.fromARGB(255, 220, 104, 145)),
                              onPressed: () {
                                // Handle edit action
                                // _showEditFeedingDialog(context, record);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                // Handle delete action
                                // _deleteFeedingRecord(mealRecords, record.id ?? '');
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedingTypeButtons() {
    return Container(
      height: 150, // Increase the height as needed
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildFeedingTypeButton('Right', Icons.water_drop),
          _buildFeedingTypeButton('Left', Icons.water_drop_outlined),
          _buildFeedingTypeButton('Bottle', Icons.local_cafe),
          _buildFeedingTypeButton('Solids', Icons.rice_bowl),
        ],
      ),
    );
  }

  Widget _buildFeedingTypeButton(String typeName, IconData iconData) {
    return GestureDetector(
      onTap: () {
        _showAddFeedingDialog(context, typeName);
      },
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 72, // Adjust the size as needed
                height: 120, // Adjust the size as needed
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      Colors.blue, // Customize the background color as needed
                ),
                child: Center(
                  child: Icon(
                    iconData,
                    size: 36,
                    color: Colors.white, // Customize the icon color as needed
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors
                        .green, // Customize the plus icon background color
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      size: 20,
                      color: Colors.white, // Customize the plus icon color
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(typeName),
        ],
      ),
    );
  }

  void _showAddFeedingDialog(BuildContext context, String typeName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add $typeName Entry'),
          content: FeedingEntryForm(typeName: typeName),
        );
      },
    );
  }
}

class FeedingEntryForm extends StatefulWidget {
  final String typeName;

  const FeedingEntryForm({Key? key, required this.typeName}) : super(key: key);

  @override
  _FeedingEntryFormState createState() => _FeedingEntryFormState();
}

class _FeedingEntryFormState extends State<FeedingEntryForm> {
  DateTime selectedDateTime = DateTime.now();
  String specialNote = '';

  Future<void> createFeedingEntry() async {
    FeedingTimes newFeeding = FeedingTimes(
      feedingType: widget.typeName,
      startTime: selectedDateTime,
      feedingNotes: specialNote,
      // Set other properties as needed.
    );

    try {
      final createdFeeding = await FeedingService.createFeeding(newFeeding);
      if (createdFeeding != null) {
        // Handle success, for example, show a message or update the UI.
        print('New feeding entry created: ${createdFeeding.id}');
        Navigator.of(context).pop(); // Close the dialog
      } else {
        // Handle the case where the API response is null.
        print('API response returned null');
        // You may want to show an error message to the user.
      }
    } catch (e) {
      // Handle the error, show an error message, or take any other appropriate action.
      print('Failed to create feeding entry: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Selected Meal Type: ${widget.typeName}'),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            final pickedDateTime = await showDatePicker(
              context: context,
              initialDate: selectedDateTime,
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );

            if (pickedDateTime != null && pickedDateTime != selectedDateTime) {
              setState(() {
                selectedDateTime = pickedDateTime;
              });
            }
          },
          child: const Text('Select Date'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            final pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );

            if (pickedTime != null) {
              setState(() {
                selectedDateTime = DateTime(
                  selectedDateTime.year,
                  selectedDateTime.month,
                  selectedDateTime.day,
                  pickedTime.hour,
                  pickedTime.minute,
                );
              });
            }
          },
          child: const Text('Select Time'),
        ),
        const SizedBox(height: 16),
        TextFormField(
          onChanged: (value) {
            setState(() {
              specialNote = value;
            });
          },
          decoration: const InputDecoration(
            hintText: 'Add a special note',
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            createFeedingEntry(); // Call the function to create a new entry
          },
          child: const Text('Add Entry'),
        ),
      ],
    );
  }
}


