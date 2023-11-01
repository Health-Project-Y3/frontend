import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thurula/services/feeding_service.dart';
import 'package:thurula/models/feeding_times_model.dart';

class MealTracker extends StatefulWidget {
  MealTracker({Key? key}) : super(key: key);

  @override
  _MealTrackerState createState() => _MealTrackerState();
}

class _MealTrackerState extends State<MealTracker> {
  List<FeedingTimes> _feedings = [];
  String? _successMessage;
  String? _errorMessage;

  FeedingTimes newFeeding = FeedingTimes();
  DateTime selectedDateTime = DateTime(2023, 10, 28, 12, 0);
  String selectedFeedingType = 'Solid';

  @override
  void initState() {
    super.initState();
    _loadFeedings();
  }

  Future<void> _loadFeedings() async {
    try {
      List<FeedingTimes> feedings = await FeedingService.getBabyFeedings('64a9cb10ec5c9834ff73fc36');
      setState(() {
        _feedings = feedings;
      });
    } catch (e) {
      print('Failed to load feedings: $e');
    }
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
          _buildFeedingTypeButtons(),
          Expanded(
            child: ListView.builder(
              itemCount: _feedings.length,
              itemBuilder: (context, index) {
                FeedingTimes feeding = _feedings[index];
                return ListTile(
                  title: Text(feeding.feedingType ?? 'No Type'),
                  subtitle: Text(
                    DateFormat('hh:mm a dd-MM-yyyy').format(
                      feeding.startTime ?? DateTime.now(),
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Color.fromARGB(255, 220, 104, 145)),
                        onPressed: () {
                          _showEditMealDialog(context, feeding);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _handleDeleteFeeding(feeding);
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
          _showAddFeedingDialog(context);
        },
        child: Icon(Icons.add),
      ),
      bottomSheet: _successMessage != null || _errorMessage != null
          ? Container(
        color: Colors.white,
        padding: EdgeInsets.all(8.0),
        child: Text(
          _successMessage ?? _errorMessage ?? '',
          style: TextStyle(
            color: _successMessage != null ? Colors.green : Colors.red,
          ),
        ),
      )
          : null,
    );
  }

  Widget _buildFeedingTypeButtons() {
    return Container(
      height: 150,
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

  Widget _buildFeedingTypeButton(String label, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {
        _handleAddFeedingType(label);
      },
      icon: Icon(icon),
      label: Text(label),
    );
  }

  Future<void> _showAddFeedingDialog(BuildContext context) async {
    String babyId = '64a9cb10ec5c9834ff73fc36';
    String selectedFeedingType = ''; // Initialize as an empty string
    TextEditingController textController = TextEditingController();

    // Create a list of feeding types for the dropdown
    List<String> feedingTypes = ['Solid', 'Right Breast', 'Left Breast'];

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Meal Entry'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Select Feeding Type:'),
                DropdownButton<String>(
                  value: selectedFeedingType,
                  items: feedingTypes.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedFeedingType = value!;
                  },
                ),
                Text(
                  _successMessage ?? _errorMessage ?? '',
                  style: TextStyle(
                    color: _errorMessage != null ? Colors.red : Colors.green,
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
                if (selectedFeedingType.isNotEmpty) { // Check if it's not empty
                  newFeeding.feedingType = selectedFeedingType;
                  newFeeding.babyId = babyId;

                  try {
                    final response = await FeedingService.createFeeding(newFeeding);

                    if (response == 'success') {
                      _successMessage = 'Meal added successfully';
                      newFeeding = FeedingTimes();
                      _loadFeedings();
                    } else {
                      _errorMessage = 'Error adding meal. Response: $response';
                    }
                  } catch (e) {
                    _errorMessage = 'Error: $e';
                  }

                  Navigator.of(context).pop();
                  setState(() {});
                }
              },
            ),
          ],
        );
      },
    );
  }







  void _handleDeleteFeeding(FeedingTimes? feeding) async {
    if (feeding != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Delete Feeding'),
          content: Text('Are you sure you want to delete this feeding?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await FeedingService.deleteFeeding(feeding.id!);
                setState(() {
                  _feedings.remove(feeding);
                  _successMessage = 'Feeding deleted successfully.';
                });
                Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
          ],
        ),
      );
    }
  }

  void _handleAddFeedingType(String feedingType) {
    newFeeding.feedingType = feedingType;
  }

  Future<void> _showEditMealDialog(BuildContext context, FeedingTimes existingMeal) async {
    if (existingMeal == null) {
      return;
    }

    FeedingTimes updatedMeal = FeedingTimes(
      id: existingMeal.id,
      feedingType: existingMeal.feedingType,
      startTime: existingMeal.startTime,
      endTime: existingMeal.endTime,
      feedingAmount: existingMeal.feedingAmount,
      feedingNotes: existingMeal.feedingNotes,
      feedingMood: existingMeal.feedingMood,
      loggedBy: existingMeal.loggedBy,
    );
    DateTime selectedDateTime = existingMeal.startTime ?? DateTime.now();
    String message = '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Edit Meal Entry'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      onChanged: (text) {
                        updatedMeal.feedingType = text;
                      },
                      decoration: InputDecoration(
                        labelText: 'Feeding Type',
                        hintText: existingMeal.feedingType,
                      ),
                    ),
                    Row(
                      children: [
                        Text('Date and Time: '),
                        Text(DateFormat('HH:mm:ss dd-MM-yyyy').format(
                            selectedDateTime.toLocal())),
                        SizedBox(width: 10),
                      ],
                    ),
                    ElevatedButton(
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
                            initialTime: TimeOfDay.fromDateTime(selectedDateTime),
                          );
                          if (pickedTimeOfDay != null) {
                            setState(() {
                              selectedDateTime = DateTime(
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
                      child: Text('Select Date and Time'),
                    ),
                    Text(message ?? '', style: TextStyle(
                      color: message == 'Error' ? Colors.red : Colors.green,
                    )),
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
                    if (updatedMeal.feedingType != null &&
                        updatedMeal.feedingType!.isNotEmpty) {
                      updatedMeal.startTime = selectedDateTime;

                      try {
                        if (existingMeal.id != null) {
                          await FeedingService.updateFeeding(existingMeal.id!, updatedMeal);
                        }

                        message = 'Meal entry updated successfully!';
                        Navigator.of(context).pop();
                        setState(() {
                          existingMeal.feedingType = updatedMeal.feedingType;
                          existingMeal.startTime = updatedMeal.startTime;
                          existingMeal.endTime = updatedMeal.endTime;
                          existingMeal.feedingAmount = updatedMeal.feedingAmount;
                          existingMeal.feedingNotes = updatedMeal.feedingNotes;
                          existingMeal.feedingMood = updatedMeal.feedingMood;
                          existingMeal.loggedBy = updatedMeal.loggedBy;
                        });
                      } catch (e) {
                        message = 'Error: $e';
                      }
                    } else {
                      message = 'Please provide a feeding type.';
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
  Widget _buildFeedingTimePicker() {
    DateTime selectedDateTime = newFeeding.startTime ?? DateTime.now();
    return ElevatedButton(
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
            initialTime: TimeOfDay.fromDateTime(selectedDateTime),
          );
          if (pickedTimeOfDay != null) {
            setState(() {
              selectedDateTime = DateTime(
                pickedDateTime.year,
                pickedDateTime.month,
                pickedDateTime.day,
                pickedTimeOfDay.hour,
                pickedTimeOfDay.minute,
              );
              newFeeding.startTime = selectedDateTime;
            });
          }
        }
      },
      child: Text('Select Date and Time'),
    );
  }
}
