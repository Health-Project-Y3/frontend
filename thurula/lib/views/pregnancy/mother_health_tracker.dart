import 'package:flutter/material.dart';
import 'package:thurula/views/pregnancy/add_weight.dart';
import 'package:thurula/views/pregnancy/add_pressure.dart';
import 'package:thurula/views/pregnancy/add_water.dart';
import 'package:thurula/services/auth/user_service.dart';
import 'package:thurula/models/user_model.dart';
import 'package:thurula/services/user_weight_service.dart';
import 'package:thurula/models/user_weight_model.dart';
import 'package:thurula/services/user_bp_service.dart';
import 'package:thurula/models/user_bp_model.dart';
import 'package:thurula/services/user_drinking_service.dart';
import 'package:thurula/models/user_drinking_model.dart';
import 'package:thurula/services/user_bmi_service.dart';
import 'package:thurula/services/local_service.dart';

import '../widgets/navbar_widget.dart';

class MotherHealthTracker1 extends StatefulWidget {
  const MotherHealthTracker1({Key? key}) : super(key: key);

  @override
  _HealthTrackerState createState() => _HealthTrackerState();
}

class _HealthTrackerState extends State<MotherHealthTracker1> {

  bool isModalOpen = false;
  double? _userWeight;
  late Future<List<UserDrinking>> _userDrinkingsFuture;

  @override
  void initState() {
    super.initState();
    _userDrinkingsFuture = _fetchUserDrinkings();
  }


  Future<User?> _getUserData() async {
    String userId = await LocalService.getCurrentUserId();
    return UserService.getUser(userId);
  }

  Future<String?> checkBmiRange() async {
    String userId = await LocalService.getCurrentUserId();
    return UserBmiService.checkBmiRange(userId);
  }

  Future<UserBp> _getLastBloodPressure() async {
    String userId = await LocalService.getCurrentUserId();
    try {
      List<UserBp> userBps = await UserBpService.getUserBps(
          userId,
          null,
          null);
      if (userBps.isNotEmpty) {
        userBps.sort((a, b) => b.date!.compareTo(a.date!));
        return userBps.first;
      } else {
        return UserBp(bloodPressure: '', date: null);
      }
    } catch (e) {
      print("Error fetching the last blood pressure record: $e");
      // Handle the error gracefully by returning a default UserBp
      return UserBp(bloodPressure: '', date: null);
    }
  }

  Future<int> getLastBloodPressureValue() async {
    String userId = await LocalService.getCurrentUserId();
    try {
      UserBp lastUserBp = await _getLastBloodPressure();
      String? bloodPressure = lastUserBp.bloodPressure;
      int value = extractFirstThreeDigits(bloodPressure);
      return value;
    } catch (e) {
      print("Error fetching and extracting blood pressure value: $e");
      // Handle the error gracefully by returning a default value
      return 0;
    }
  }

  int extractFirstThreeDigits(String? bloodPressure) {
    String? firstThreeChars = bloodPressure?.substring(0, 3);
    int value = int.tryParse(firstThreeChars ?? "0") ?? 0;
    return value;
  }

  Future<List<UserWeight>> _getUserWeights() async {
    String userId = await LocalService.getCurrentUserId();
    List<UserWeight> userWeights = await UserWeightService.getUserWeights(
        userId, null, null);
    return userWeights;
  }

  Future<List<UserDrinking>> _fetchUserDrinkings() async {
    String userId = await LocalService.getCurrentUserId();
    final today = DateTime.now();
    final startDate = DateTime(today.year, today.month, today.day);
    final endDate = startDate.add(Duration(days: 1));

    try {
      final userDrinkings = await UserDrinkingService.getUserDrinkings(
        userId,
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
      return userDrinkings;
    } catch (e) {
      print('Error fetching user drinkings: $e');
      return [];
    }
  }

  Widget buildBMIWidget() {
    return FutureBuilder<String?>(
      future: checkBmiRange(), // Replace 'userId' with the actual user ID
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return buildLoadingIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final bmiResult = snapshot.data;
          String changeText;
          Color textColor;

          if (bmiResult == 'low') {
            changeText = 'Healthy';
            textColor = Colors.green;
          } else if (bmiResult == 'average') {
            changeText = 'Over Weight';
            textColor = Colors.yellow;
          } else if (bmiResult == 'Obese') {
            changeText = 'High BMI';
            textColor = Colors.red;
          } else {
            changeText = 'Unknown BMI';
            textColor = Colors.black;
          }

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            decoration: BoxDecoration(
              color: textColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              changeText,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          );
        } else {
          return Text('No BMI data available');
        }
      },
    );
  }

  Widget buildLoadingIndicator() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: CircularProgressIndicator(),
    );
  }

  Widget buildWeightChangeCard(List<UserWeight> userWeights) {
    userWeights.sort((a, b) => b.date!.compareTo(a.date!));
    final double latestWeight = userWeights[0].weight!;
    final double secondLatestWeight = userWeights[1].weight!;
    double weightChange = latestWeight - secondLatestWeight;
    String changeText = "No change in weight";
    Color textColor = Colors.black;

    if (weightChange > 0) {
      changeText = "You have gained ${weightChange.toStringAsFixed(1)} kg";
      textColor = Colors.red;
    } else if (weightChange < 0) {
      changeText = "You have lost ${(-weightChange).toStringAsFixed(1)} kg";
      textColor = Colors.green;
    }

    return Text(
      changeText,
      style: TextStyle(
        fontSize: 14,
        color: textColor,
      ),
    );
  }

  Widget buildUserWeightCard(double userWeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 4.0),
          child: Text(
            'I weigh',
            style: TextStyle(
              color: Color.fromARGB(255, 88, 119, 161),
              fontSize: 16.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            "${userWeight.toStringAsFixed(1)} Kg",
            style: TextStyle(
              fontSize: 36.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 88, 119, 161),
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(18.0, 2.0, 18.0, 18.0),
        //   child: FutureBuilder<List<UserWeight>(
        //     future: _getUserWeights(),
        //     builder: (context, userWeightsSnapshot) {
        //       if (userWeightsSnapshot.connectionState == ConnectionState.waiting) {
        //         return buildLoadingIndicator();
        //       } else if (userWeightsSnapshot.hasData && userWeightsSnapshot.data!.length >= 2) {
        //         return buildWeightChangeCard(userWeightsSnapshot.data!);
        //       } else {
        //         return Text('User weight not available');
        //       }
        //     },
        //   ),
        // ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Tracker'),
        backgroundColor: Color.fromARGB(255, 220, 104, 145),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          onPressed: () {

            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Weight Card
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => WeightMonitorPage(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 2.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 400,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0.5,
                              blurRadius: 3,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FutureBuilder<List<UserWeight>>(
                                    future: _getUserWeights(),
                                    builder: (context, userWeightsSnapshot) {
                                      if (userWeightsSnapshot.connectionState == ConnectionState.waiting) {
                                        return buildLoadingIndicator();
                                      } else if (userWeightsSnapshot.hasData && userWeightsSnapshot.data!.isNotEmpty) {
                                        final double userWeight = userWeightsSnapshot.data!.last.weight ?? 0.0;
                                        return buildUserWeightCard(userWeight);
                                      } else {
                                        return FutureBuilder<User?>(
                                          future: _getUserData(),
                                          builder: (context, userSnapshot) {
                                            if (userSnapshot.connectionState == ConnectionState.waiting) {
                                              return buildLoadingIndicator();
                                            } else if (userSnapshot.hasData) {
                                              final double userWeight = userSnapshot.data!.preWeight ?? 0.0;
                                              return buildUserWeightCard(userWeight);
                                            } else {
                                              return Text('User weight not available');
                                            }
                                          },
                                        );
                                      }
                                    },
                                  ),


                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 18.0), // Add padding to the BMI widget
                                    child: buildBMIWidget(),
                                  ), // Add the BMI widget outside of the conditional statement
                                ],
                              ),
                            ),


                            // Add your second column here

                            // Container for the image with specified width and height
                            Container(
                              width: 180,
                              height: 180,
                              child: Image.asset(
                                'assets/images/health_tracker/Weight.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Box 2 (Weight Growth Chart)
                Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 2.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WeightChartBox(getUserWeights: _getUserWeights),
                    ],
                  ),
                ),











                // Box 3
                // Box 3
                GestureDetector(
                  onTap: () {
                    // Navigate to the new page when the box is tapped
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddPressurePage(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 2.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 400, // Limit the width to a specific value
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0.5,
                              blurRadius: 3,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: SingleChildScrollView( // Wrap the content with SingleChildScrollView
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FutureBuilder<UserBp>(
                                future: _getLastBloodPressure(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text(
                                      "Error: ${snapshot.error}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 88, 119, 161),
                                      ),
                                    );
                                  } else {
                                    final lastRecord = snapshot.data;
                                    if (lastRecord != null) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 8.0, 18.0),
                                                child: Text(
                                                  'My blood pressure',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(255, 88, 119, 161),
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ),

                                              // Container(
                                              //   child: FutureBuilder<int>(
                                              //     future: getLastBloodPressureValue(),
                                              //     builder: (context, snapshot) {
                                              //       if (snapshot.connectionState == ConnectionState.waiting) {
                                              //         return Center(
                                              //           child: CircularProgressIndicator(),
                                              //         ); // Show a loading indicator while waiting.
                                              //       } else if (snapshot.hasError) {
                                              //         return Center(
                                              //           child: Text("Error: ${snapshot.error}"),
                                              //         ); // Handle the error case.
                                              //       } else {
                                              //         int bloodPressureValue = snapshot.data ?? 0;
                                              //         String bpStatus = getBloodPressureStatus(bloodPressureValue);
                                              //
                                              //
                                              //
                                              //         return Container(
                                              //           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                                              //           decoration: BoxDecoration(
                                              //             color:getBackgroundColorForStatus(bloodPressureValue),
                                              //             borderRadius: BorderRadius.circular(10),
                                              //           ),
                                              //           child: Text(
                                              //             bpStatus,
                                              //             style: TextStyle(
                                              //               fontSize: 10,
                                              //               color: Colors.white,
                                              //             ),
                                              //           ),
                                              //         );
                                              //       }
                                              //     },
                                              //   ),
                                              // ),

                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(18.0, 4.0, 0.0, 30.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${lastRecord.bloodPressure} mmHg",
                                                  style: TextStyle(
                                                    fontSize: 28,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(255, 88, 119, 161),
                                                  ),
                                                ),
                                                SizedBox(height: 20), // Add a gap of 10 units between the Text and Container

                                                Container(

                                                  child: FutureBuilder<int>(
                                                    future: getLastBloodPressureValue(),
                                                    builder: (context, snapshot) {
                                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                                        return Center(
                                                          child: CircularProgressIndicator(),
                                                        ); // Show a loading indicator while waiting.
                                                      } else if (snapshot.hasError) {
                                                        return Center(
                                                          child: Text("Error: ${snapshot.error}"),
                                                        ); // Handle the error case.
                                                      } else {
                                                        int bloodPressureValue = snapshot.data ?? 0;
                                                        String bpStatus = getBloodPressureStatus(bloodPressureValue);

                                                        return Container(
                                                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                                          decoration: BoxDecoration(
                                                            color: getBackgroundColorForStatus(bloodPressureValue),
                                                            borderRadius: BorderRadius.circular(10),
                                                          ),
                                                          child: Text(
                                                            bpStatus,
                                                            style: TextStyle(
                                                              fontSize: 10,
                                                              color: Colors.white,
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )



                                        ],
                                      );
                                    } else {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 4.0),
                                            child: Text(
                                              'My blood pressure',
                                              style: TextStyle(
                                                color: Color.fromARGB(255, 88, 119, 161),
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(18.0, 4.0, 18.0, 4.0),
                                            child: Text(
                                              "0/0",
                                              style: TextStyle(
                                                fontSize: 32,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(255, 88, 119, 161),
                                              ),
                                            ),
                                          ),

                                        ],
                                      );
                                    }
                                  }
                                },
                              ),




                              Container(
                                width: 180, // You can adjust the width as needed
                                height: 180, // You can adjust the height as needed
                                child: Image.asset(
                                  'assets/images/health_tracker/Blood.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),


                // Box 4 (Copy the above code with different content)
                GestureDetector(
                  onTap: () {
                    // Navigate to the new page when the box is tapped
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => WaterMonitorPage(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 400,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0.5,
                              blurRadius: 3,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        18.0, 18.0, 18.0, 6.0),
                                    child: Text(
                                      'I Drank',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 88, 119, 161),
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                  FutureBuilder<List<UserDrinking>>(
                                    future: _userDrinkingsFuture,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else if (snapshot.hasData) {
                                        final today = DateTime.now();
                                        final startDate = DateTime(
                                            today.year, today.month, today.day);
                                        final endDate =
                                            startDate.add(Duration(days: 1));
                                        final totalGlasses = snapshot.data!
                                            .where((drinking) =>
                                                drinking.date != null &&
                                                drinking.date!
                                                    .isAfter(startDate) &&
                                                drinking.date!
                                                    .isBefore(endDate))
                                            .fold<int>(0, (total, drinking) {
                                          return total +
                                              (drinking.glassesDrunk ?? 0);
                                        });

                                        // Calculate balance needed to achieve 11
                                        final balanceNeeded = 11 - totalGlasses;

                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 6.0), // You can adjust the padding as needed
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
                                            children: [
                                              Text(
                                                "$totalGlasses Glasses",
                                                style: TextStyle(
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(255, 88, 119, 161),
                                                ),
                                              ),
                                              if (balanceNeeded > 0)
                                                Container(
                                                  padding: EdgeInsets.only(top: 20), // Adjust the left padding as needed
                                                  child: Text(
                                                    "Drink $balanceNeeded More Glasess",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color.fromARGB(255, 88, 119, 161),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        );


                                      } else {
                                        return Text('No data available.');
                                      }
                                    },
                                  ),

                                ],
                              ),
                            ),
                            // Container for the image with specified width and height
                            Container(
                              width: 160,
                              height: 160,
                              child: Image.asset(
                                'assets/images/health_tracker/Water.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isModalOpen)
            Container(
              color: Color.fromRGBO(0, 0, 0, 0.4), // Overlay color
            ),
        ],
      ),
      bottomNavigationBar: const CreateBottomNavigationBar(pageIndex: 1),
    );
  }
}

class WeightChartBox extends StatelessWidget {
  final Future<List<UserWeight>?> Function() getUserWeights;

  WeightChartBox({required this.getUserWeights});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FutureBuilder<List<UserWeight>?>(
            future: getUserWeights(),
            builder: (context, userWeightsSnapshot) {
              if (userWeightsSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return Text('');
              } else {
                final userWeights = userWeightsSnapshot.data ?? [];
                final minWeight = userWeights.isEmpty
                    ? 0
                    : userWeights
                        .map((weight) => weight.weight!)
                        .reduce((a, b) => a < b ? a : b)
                        .toInt();
                final maxWeight = userWeights.isEmpty
                    ? 20
                    : userWeights
                        .map((weight) => weight.weight!)
                        .reduce((a, b) => a > b ? a : b)
                        .toInt();
                final chartHeight = (maxWeight - minWeight + 20) *
                    2.0; // Reduce the chart height
                final chartWidth = 36 * 20.0; // Adjusted the width for 36 weeks

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0,
                          left:
                              20.0), // Add left padding to "Weight (kg)" and reduce top padding
                      child: Text(
                        'Weight Chart',
                        style: TextStyle(
                          color: Color.fromARGB(255, 88, 119, 161),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0,
                          left: 20.0), // Add left padding under "Weight (kg)"
                      child: Text(
                        'Weight (kg)',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis
                          .horizontal, // Make the chart scrollable horizontally
                      child: Row(
                        children: [
                          // Y-axis (displayed on the left)
                          Container(
                            width: 60.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: List.generate(
                                (maxWeight - minWeight) ~/ 20 + 1,
                                (index) {
                                  if (index % 20 == 0) {
                                    final label =
                                        (minWeight + 20 * index).toString();
                                    return Text('');
                                  } else {
                                    return Text('');
                                  }
                                },
                              ),
                            ),
                          ),
                          // Add padding around the chart
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical:
                                    20.0), // Increase vertical padding here
                            child: SizedBox(
                              width: chartWidth,
                              height: chartHeight,
                              child: CustomPaint(
                                size: Size(chartWidth, chartHeight),
                                painter: ChartPainter(
                                    userWeights, minWeight, maxWeight),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // X-axis label at the bottom right corner
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          'Weeks',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class ChartPainter extends CustomPainter {
  final List<UserWeight> userWeights;
  final int minWeight;
  final int maxWeight;

  ChartPainter(this.userWeights, this.minWeight, this.maxWeight);

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Color.fromARGB(255, 88, 119, 161) // Color for the lines
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final pointPaint = Paint()
      ..color = Color.fromARGB(255, 220, 104, 145) // Color for the points
      ..strokeWidth = 4.0;

    final maxY = 120; // Max weight on the y-axis
    final yLabelInterval = 20; // Interval between y-axis labels
    final maxX = 32; // Max weeks on the x-axis
    final xLabelInterval = 1; // Interval between x-axis labels

    final xAxisStart = Offset(0, size.height);
    final xAxisEnd = Offset(size.width, size.height);
    final yAxisStart = Offset(0, size.height);
    final yAxisEnd = Offset(0, 0);

    canvas.drawLine(xAxisStart, xAxisEnd, linePaint);
    canvas.drawLine(yAxisStart, yAxisEnd, linePaint);

    final yLabelOffset = Offset(-40, 0);
    final yLabelStyle = TextStyle(
      color: Colors.black,
      fontSize: 12,
    );

    final xLabelOffset = Offset(0, 10);
    final xLabelStyle = TextStyle(
      color: Colors.black,
      fontSize: 12,
    );

    final yLabels = ['0', '40', '80', '120']; // Y-axis labels

    for (var i = 0; i < yLabels.length; i++) {
      final y = size.height - (int.parse(yLabels[i]) * size.height / maxY);
      final labelText = yLabels[i];
      final yLabelPainter = TextPainter(
        text: TextSpan(
          text: labelText,
          style: yLabelStyle,
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      yLabelPainter.layout();
      yLabelPainter.paint(canvas, Offset(-40, y - 6));
    }

    for (var i = 1; i <= maxX; i += xLabelInterval) {
      final x = (i * size.width / maxX);
      final labelText = i.toString();
      final xLabelPainter = TextPainter(
        text: TextSpan(
          text: labelText,
          style: xLabelStyle,
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      xLabelPainter.layout();
      xLabelPainter.paint(canvas, Offset(x, size.height) + xLabelOffset);
    }

    for (var i = 0; i < userWeights.length - 1; i++) {
      final x1 = (i * size.width / (maxX - 1));
      final y1 = size.height - (userWeights[i].weight! * size.height / maxY);
      final x2 = ((i + 1) * size.width / (maxX - 1));
      final y2 =
          size.height - (userWeights[i + 1].weight! * size.height / maxY);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), linePaint);
      canvas.drawCircle(Offset(x1, y1), 4.0, pointPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ModalContent extends StatefulWidget {
  _ModalContent createState() => _ModalContent();
  final Function closeModal;
  ModalContent({required this.closeModal});
}

class _ModalContent extends State<ModalContent> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  // Initialize the controllers with initial values (if available)
  @override
  void initState() {
    super.initState();

    // Example: Set initial values if available
    heightController.text =
        'Initial Height Value'; // Replace with your initial value
    weightController.text =
        'Initial Weight Value'; // Replace with your initial value
  }

  String get height => heightController.text;
  String get weight => weightController.text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 500.0,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Pre-Pregnancy Details",
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25.0),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          "Before we embark on this incredible journey together, ",
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    TextSpan(
                      text: "Please add your ",
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    TextSpan(
                      text: "pre-pregnancy height and weight",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Color.fromARGB(255, 220, 104, 145),
                      ),
                    ),
                    TextSpan(
                      text:
                          " details to ensure your well-being and a healthy pregnancy.",
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                  "Maintaining a healthy weight and understanding your body's baseline is essential for a successful and comfortable pregnancy."),
              SizedBox(height: 16.0),
              SizedBox(height: 12.0),
              TextField(
                controller: heightController,
                decoration: InputDecoration(
                  labelText: 'Height (cm/inch)',
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: weightController,
                decoration: InputDecoration(
                  labelText: 'Weight (kg/lbs)',
                ),
              ),
              SizedBox(height: 12.0),
              SizedBox(height: 16.0),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (height.isNotEmpty && weight.isNotEmpty) {
                        double heightValue = double.parse(height);
                        double weightValue = double.parse(weight);

                        // Create a User object with the updated values
                        User updatedUser = User(
                          height: heightValue,
                          preWeight: weightValue,
                        );

                        // Call the updateUser method to update the user's data in the database
                        UserService.updateUser(
                                '651565c2e11d243e01ee0565', updatedUser)
                            .then((_) {
                          // Data updated successfully, close the modal
                          widget.closeModal(); // Close the modal
                        }).catchError((error) {
                          // Handle any errors that occur during the update
                          print('Error updating user data: $error');
                          // You can also show an error message to the user
                        });
                      } else {
                        print('Error');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 220, 104, 145),
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


String getBloodPressureStatus(int bpValue) {


  if (bpValue >= 70 && bpValue < 90) {
    return "Low";
  } else if (bpValue >= 90 && bpValue < 120) {
    return "Ideal";
  } else if (bpValue >= 120 && bpValue < 140) {
    return "Pre high";
  } else {
    return "High";
  }
}
Color getBackgroundColorForStatus(int bloodPressure) {
  String status = getBloodPressureStatus(bloodPressure);
  switch (status) {
    case "Low":
      return Colors.green;
    case "Ideal":
      return Colors.blue;
    case "Pre high":
      return Colors.orange;
    case "High":
      return Colors.red; // Red background for "High" status
    default:
      return Colors.red; // Default red background for any other status
  }}