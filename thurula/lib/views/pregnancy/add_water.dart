import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:thurula/models/user_drinking_model.dart';
import 'package:thurula/services/user_drinking_service.dart';
import 'package:thurula/views/pregnancy/view_water_records.dart';

import '../../providers/user_provider.dart';
import 'mother_health_tracker.dart';
class WaterMonitorPage extends StatefulWidget {
  @override
  _WaterMonitorPageState createState() => _WaterMonitorPageState();
}

class _WaterMonitorPageState extends State<WaterMonitorPage> {
  String? _selectedOption;
  String? userId;
  late Future<List<UserDrinking>> _userDrinkingsFuture;

  @override
  void initState() {
    userId= context.read<UserProvider>().user?.id ?? '';
    super.initState();
    _userDrinkingsFuture = _fetchUserDrinkings();
  }

  Future<List<UserDrinking>> _fetchUserDrinkings() async {
    final today = DateTime.now();
    final startDate = DateTime(today.year, today.month, today.day);
    final endDate = startDate.add(Duration(days: 1));

    try {
      final userDrinkings = await UserDrinkingService.getUserDrinkings(
        userId!,
        startDate.toIso8601String(),
        endDate.toIso8601String(),
      );

      final totalGlasses = userDrinkings
          .where((drinking) =>
      drinking.date != null &&
          drinking.date!.isAfter(startDate) &&
          drinking.date!.isBefore(endDate))
          .fold<int>(0, (total, drinking) {
        return total + (drinking.glassesDrunk ?? 0);
      });

      // Show congratulatory message if total is 11
      if (totalGlasses >= 11) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(
                child: Text(
                  'Congratulations!',
                  style: TextStyle(
                    fontSize: 24, // Adjust the font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      '🎉', // Add a party emoji
                      style: TextStyle(
                        fontSize: 48, // Adjust the font size
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      '\n You have reached your daily water intake goal of 11 glasses.',
                      textAlign: TextAlign.center, // Center the text
                      style: TextStyle(
                        fontSize: 16, // Adjust the font size
                      ),
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                Center(
                  child: TextButton(
                    child: Text(
                      'Close',
                      style: TextStyle(
                        fontSize: 18, // Adjust the font size
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            );

          },
        );
      }

      setState(() {
        _selectedOption = null; // Clear selected option
      });

      return userDrinkings;
    } catch (e) {
      print('Error fetching user drinkings: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Water Intake'),
        backgroundColor: Color.fromARGB(255, 220, 104, 145),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // You can use a different icon if desired
          onPressed: () {
            // Add navigation logic to go to the "Mother Health Tracker" page
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MotherHealthTracker1()), // Replace with your actual page widget
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "How Much Water Do You Need?",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 88, 119, 161),
                    ),
                  ),
                  SizedBox(height: 14),
                  Text(
                    "During pregnancy, your body has increased demands, and one crucial aspect is staying well-hydrated...",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 28),
                  FutureBuilder<List<UserDrinking>>(
                    future: _userDrinkingsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final today = DateTime.now();
                        final startDate = DateTime(today.year, today.month, today.day);
                        final endDate = startDate.add(Duration(days: 1));
                        final totalGlasses = snapshot.data!
                            .where((drinking) =>
                        drinking.date != null &&
                            drinking.date!.isAfter(startDate) &&
                            drinking.date!.isBefore(endDate))
                            .fold<int>(0, (total, drinking) {
                          return total + (drinking.glassesDrunk ?? 0);
                        });

                        // Calculate balance needed to achieve 11
                        final balanceNeeded = 11 - totalGlasses;

                        return Column(
                          children: [
                            Text(
                              "I've Drank $totalGlasses Glasses",
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 88, 119, 161),
                              ),
                            ),
                            if (balanceNeeded > 0)
                              SizedBox(height: 18),
                              Text(
                                "🎉 $balanceNeeded Glasses to achieve the daily milestone",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 220, 104, 145),
                                ),
                              ),
                          ],
                        );
                      } else {
                        return Text('No data available.');
                      }
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              color: Colors.white,
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedOption,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedOption = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Select Option',
                    ),
                    items: [
                      DropdownMenuItem<String>(
                        value: '1',
                        child: Text('1 Glass (240ml)'),
                      ),
                      DropdownMenuItem<String>(
                        value: '2',
                        child: Text('2 Glasses (480ml)'),
                      ),
                      DropdownMenuItem<String>(
                        value: '3',
                        child: Text('3 Glasses (720ml)'),
                      ),
                      DropdownMenuItem<String>(
                        value: '4',
                        child: Text('4 Glasses (960ml)'),
                      ),
                      DropdownMenuItem<String>(
                        value: '5',
                        child: Text('5 Glasses (1200ml)'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // ... (previous code)

            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Use Navigator to navigate to the desired page
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return ViewWaterPage();
                              },
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 88, 119, 161), // Change the background color
                          padding: EdgeInsets.all(18),
                        ),
                        child: Text(
                          'View Records',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 8), // Add a small gap between the buttons
                      ElevatedButton(
                        onPressed: () async {
                          final selectedOption = _selectedOption;

                          if (selectedOption != null) {
                            final glassesDrunk = int.tryParse(selectedOption);
                            if (glassesDrunk != null) {
                              final newUserDrinking = UserDrinking(
                                userId: userId,
                                glassesDrunk: glassesDrunk,
                                date: DateTime.now(),
                              );

                              try {
                                await UserDrinkingService.createUserDrinking(newUserDrinking);
                                setState(() {
                                  _userDrinkingsFuture = _fetchUserDrinkings();
                                });
                                Fluttertoast.showToast(
                                  msg: "Record added successfully",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.green, // Change the background color
                                  textColor: Colors.white, // Text color
                                );
                              } catch (e) {
                                Fluttertoast.showToast(
                                  msg: "Error adding record: $e",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.red, // Change the background color
                                  textColor: Colors.white, // Text color
                                );
                                print('Error creating user drinking record: $e');
                              }
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 220, 104, 145), // Change the background color
                          padding: EdgeInsets.all(18),
                          minimumSize: Size(240, 0), // Adjust the width of the button
                        ),
                        child: Text(
                          'Add Record',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),



                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
