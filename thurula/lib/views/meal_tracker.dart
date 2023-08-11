import 'package:flutter/material.dart';

class MealTracker extends StatefulWidget {
  @override
  _MealTrackerState createState() => _MealTrackerState();
}

class _MealTrackerState extends State<MealTracker> {
  DateTime selectedDate = DateTime.now();
  List<String> feedingEntries = ['Milk', 'Puree', 'Fruits', 'Rice'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baby MealTracker'),
        backgroundColor: Color.fromARGB(255, 220, 104, 145), // Custom app bar color
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            child: Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: feedingEntries.length + 1,
                itemBuilder: (context, index) {
                  if (index < feedingEntries.length) {
                    return _FeedingTypeCircle(feedingType: feedingEntries[index]);

                  } else {
                    return _AddFeedingCircle(
                      onAddPressed: () {
                        _showAddFeedingDialog(context);
                      },

                    );
                  }
                },
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Milk'),
                  subtitle: Text('5.30pm 24-05-2023'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Color.fromARGB(255, 220, 104, 145)), // Custom edit icon color
                        onPressed: () {
                          // Handle edit action
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red), // Change to your custom color
                        onPressed: () {
                          // Handle delete action
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Statistics and Summary'),
          ),
        ],
      ),
    );
  }


  void _showAddFeedingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Feeding Entry'),
          content: FeedingEntryForm(),
        );
      },
    );
  }
}

class FeedingEntryForm extends StatefulWidget {
  @override
  _FeedingEntryFormState createState() => _FeedingEntryFormState();
}

class _FeedingEntryFormState extends State<FeedingEntryForm> {
  String selectedMealType = 'Breakfast';
  DateTime selectedDateTime = DateTime.now();
  String specialNote = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DropdownButton<String>(
          value: selectedMealType,
          onChanged: (newValue) {
            setState(() {
              selectedMealType = newValue!;
            });
          },
          items: ['Breakfast', 'Lunch', 'Dinner', 'Snack']
              .map<DropdownMenuItem<String>>(
                (value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          )
              .toList(),
        ),
        SizedBox(height: 16),
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
          child: Text('Select Date'),
        ),
        SizedBox(height: 16),
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
          child: Text('Select Time'),
        ),
        SizedBox(height: 16),
        TextFormField(
          onChanged: (value) {
            setState(() {
              specialNote = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Add a special note',
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            // Handle form submission and update UI
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Add Entry'),
        ),
      ],
    );
  }
}

class _FeedingTypeCircle extends StatelessWidget {
  final String feedingType;

  const _FeedingTypeCircle({required this.feedingType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 220, 104, 145),
                ),
                child: Center(
                  child: Text(
                    feedingType[0],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(feedingType),
            ],
          ),
          GestureDetector(
            onTap: () {
              // Handle adding entry for this feeding type
              // _showAddFeedingDialog(context);
            },
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddFeedingCircle extends StatelessWidget {
  final VoidCallback onAddPressed;

  const _AddFeedingCircle({required this.onAddPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: onAddPressed,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text('Add Meal Type'),
        ],
      ),
    );
  }
}

