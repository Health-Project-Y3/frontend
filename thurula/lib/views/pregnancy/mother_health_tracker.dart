import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:thurula/views/pregnancy/add_weight.dart';
import 'package:thurula/views/pregnancy/add_pressure.dart';
import 'package:thurula/views/pregnancy/add_water.dart';
import 'package:thurula/services/auth/user_service.dart';
import 'package:thurula/models/user_model.dart';
import 'package:thurula/services/user_weight_service.dart';
import 'package:thurula/models/user_weight_model.dart';

class MotherHealthTracker1 extends StatefulWidget {
  const MotherHealthTracker1({Key? key}) : super(key: key);

  @override
  _HealthTrackerState createState() => _HealthTrackerState();
}

class _HealthTrackerState extends State<MotherHealthTracker1> {
  bool isModalOpen = false;
  double? _userWeight;

  @override
  void initState() {
    super.initState();
  }

  Future<User?> _getUserData() async {
    return UserService.getUser('652a5d43935d40f339c12d8b');
  }

  Future<List<UserWeight>> _getUserWeights() async {
    // Fetch user weights here, using the UserWeightService
    // Pass the user's ID and set null for the start and end date as needed
    List<UserWeight> userWeights = await UserWeightService.getUserWeights(
        '652a5d43935d40f339c12d8b', null, null);
    return userWeights;
  }

  void _openModal() {
    Future.delayed(Duration.zero, () {
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext context) {
          return ModalContent(
            closeModal: () {
              setState(() {
                isModalOpen = false;
              });
              Navigator.pop(context);
            },
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Tracker'),
        backgroundColor: Color.fromARGB(255, 220, 104, 145),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // You can use a different icon if desired
          onPressed: () {
            // Add navigation logic to go back to the previous page
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
                // Box 1
                GestureDetector(
                  onTap: () {
                    // Navigate to the new page when the box is tapped
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
                                      if (userWeightsSnapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      } else if (userWeightsSnapshot.hasData &&
                                          userWeightsSnapshot
                                              .data!.isNotEmpty) {
                                        final double userWeight =
                                            userWeightsSnapshot
                                                    .data!.last.weight ??
                                                0.0;
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      18.0, 18.0, 18.0, 4.0),
                                              child: Text(
                                                'I weigh',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 88, 119, 161),
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: Text(
                                                "${userWeight.toStringAsFixed(1)} Kg",
                                                style: TextStyle(
                                                  fontSize: 36.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 88, 119, 161),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      18.0, 2.0, 18.0, 18.0),
                                              child: FutureBuilder<List<UserWeight>>(
                                                future: _getUserWeights(),
                                                builder: (context, userWeightsSnapshot) {
                                                  if (userWeightsSnapshot.connectionState == ConnectionState.waiting) {
                                                    return CircularProgressIndicator();
                                                  } else if (userWeightsSnapshot.hasData && userWeightsSnapshot.data!.length >= 2) {
                                                    final List<UserWeight> userWeights = userWeightsSnapshot.data!;
                                                    userWeights.sort((a, b) => b.date!.compareTo(a.date!));

                                                    final double latestWeight = userWeights[0].weight!;
                                                    final double secondLatestWeight = userWeights[1].weight!;

                                                    double weightChange = latestWeight - secondLatestWeight;

                                                    String changeText = "No change in weight";
                                                    Color textColor = Colors.black;

                                                    if (weightChange > 0) {
                                                      changeText = "You have Gained ${weightChange.toStringAsFixed(1)} kg";
                                                      textColor = Colors.red;
                                                    } else if (weightChange < 0) {
                                                      changeText = "You have lost ${(-weightChange).toStringAsFixed(1)} kg";
                                                      textColor = Colors.green;
                                                    }

                                                    return Column(
                                                      children: [
                                                        Text(
                                                          changeText,
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: textColor,
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  } else {
                                                    // If no weight records are available, fetch and display the user's weight
                                                    return FutureBuilder<User?>(
                                                      future: _getUserData(),
                                                      builder: (context, userSnapshot) {
                                                        if (userSnapshot.connectionState == ConnectionState.waiting) {
                                                          return CircularProgressIndicator();
                                                        } else {
                                                          return Text('User weight not available');
                                                        }
                                                      },
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        );
                                      } else {
                                        // If no weight records are available, fetch and display the user's weight
                                        return FutureBuilder<User?>(
                                          future: _getUserData(),
                                          builder: (context, userSnapshot) {
                                            if (userSnapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return CircularProgressIndicator();
                                            } else if (userSnapshot.hasData) {
                                              final double userWeight =
                                                  userSnapshot
                                                          .data!.preWeight ??
                                                      0.0;
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        18.0, 18.0, 18.0, 4.0),
                                                    child: Text(
                                                      'I weigh',
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 88, 119, 161),
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            18.0),
                                                    child: Text(
                                                      "${userWeight.toStringAsFixed(1)} Kg",
                                                      style: TextStyle(
                                                        fontSize: 36.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 88, 119, 161),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        18.0, 2.0, 18.0, 18.0),
                                                    child: FutureBuilder<List<UserWeight>>(
                                                      future: _getUserWeights(),
                                                      builder: (context, userWeightsSnapshot) {
                                                        if (userWeightsSnapshot.connectionState == ConnectionState.waiting) {
                                                          return CircularProgressIndicator();
                                                        } else if (userWeightsSnapshot.hasData && userWeightsSnapshot.data!.length >= 2) {
                                                          final List<UserWeight> userWeights = userWeightsSnapshot.data!;
                                                          userWeights.sort((a, b) => b.date!.compareTo(a.date!));

                                                          final double latestWeight = userWeights[0].weight!;
                                                          final double secondLatestWeight = userWeights[1].weight!;

                                                          double weightChange = latestWeight - secondLatestWeight;

                                                          String changeText = "No change in weight";
                                                          Color textColor = Colors.black;

                                                          if (weightChange > 0) {
                                                            changeText = "You have Gained ${weightChange.toStringAsFixed(1)} kg";
                                                            textColor = Colors.red;
                                                          } else if (weightChange < 0) {
                                                            changeText = "You have lost ${(-weightChange).toStringAsFixed(1)} kg";
                                                            textColor = Colors.green;
                                                          }

                                                          return Column(
                                                            children: [
                                                              Text(
                                                                changeText,
                                                                style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: textColor,
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        } else {
                                                          // If no weight records are available, fetch and display the user's weight
                                                          return FutureBuilder<User?>(
                                                            future: _getUserData(),
                                                            builder: (context, userSnapshot) {
                                                              if (userSnapshot.connectionState == ConnectionState.waiting) {
                                                                return CircularProgressIndicator();
                                                              } else {
                                                                return Text('User weight not available');
                                                              }
                                                            },
                                                          );
                                                        }
                                                      },
                                                    )
                                                  ),
                                                ],
                                              );
                                            } else {
                                              return Text(
                                                  'User weight not available');
                                            }
                                          },
                                        );
                                      }
                                    },
                                  )
                                  // Box 1
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
                                        18.0, 18.0, 18.0, 4.0),
                                    child: Text(
                                      'My Pressure Level',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 88, 119, 161),
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        18.0, 18.0, 18.0, 6.0),
                                    child: Text(
                                      '0/0',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 88, 119, 161),
                                        fontSize: 36.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        18.0, 18.0, 18.0, 2.0),
                                    child: Text(
                                      'Week on Week Gain - 10',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 88, 119, 161),
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Container for the image with specified width and height
                            Container(
                              width: 180,
                              height: 180,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 2.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PressureChartBox(),
                    ],
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
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        18.0, 18.0, 18.0, 4.0),
                                    child: Text(
                                      '5 Glasses',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 88, 119, 161),
                                        fontSize: 36.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        18.0, 18.0, 18.0, 2.0),
                                    child: Text(
                                      'I need to Drink - 400ml/day',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 88, 119, 161),
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Container for the image with specified width and height
                            Container(
                              width: 180,
                              height: 180,
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
        borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
            offset: Offset(0, 3), // Adjust the offset as needed
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Weight Chart',
              style: TextStyle(
                color: Color.fromARGB(255, 88, 119, 161),
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FutureBuilder<List<UserWeight>?>(
            future: getUserWeights(),
            builder: (context, userWeightsSnapshot) {
              if (userWeightsSnapshot.connectionState == ConnectionState.waiting) {
                return Text('');
              } else {
                final userWeights = userWeightsSnapshot.data ?? [];
                final minWeight = userWeights.isEmpty
                    ? 0
                    : userWeights.map((weight) => weight.weight!).reduce((a, b) => a < b ? a : b).toInt();
                final maxWeight = userWeights.isEmpty
                    ? 20
                    : userWeights.map((weight) => weight.weight!).reduce((a, b) => a > b ? a : b).toInt();
                final chartHeight = (maxWeight - minWeight + 10) * 5.0;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 60.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: CustomPaint(
                          size: Size(
                            38 * 5.0,
                            chartHeight,
                          ),
                          painter: ChartPainter(userWeights, minWeight, maxWeight),
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
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final maxY = userWeights.fold(0, (max, weight) => (weight.weight! > max ? weight.weight! : max).toInt());

    final xAxisStart = Offset(0, size.height);
    final xAxisEnd = Offset(size.width, size.height);
    final yAxisStart = Offset(0, 0);
    final yAxisEnd = Offset(0, size.height);

    canvas.drawLine(xAxisStart, xAxisEnd, paint);
    canvas.drawLine(yAxisStart, yAxisEnd, paint);

    final yLabelOffset = Offset(-40, -40);
    final yLabelStyle = TextStyle(
      color: Colors.black,
      fontSize: 12,
    );
    final yLabelPainter = TextPainter(
      text: TextSpan(
        text: 'Weight (Kg)',
        style: yLabelStyle,
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    yLabelPainter.layout();
    yLabelPainter.paint(canvas, yLabelOffset);

    final xLabelOffset = Offset(0, 10);
    final xLabelStyle = TextStyle(
      color: Colors.black,
      fontSize: 12,
    );
    for (var i = 0; i < userWeights.length; i++) {
      final x = i * 20.0;
      final labelText = '${i + 1}';
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

    // Add y-axis labels
    final yLabelStep = maxY / 5;
    for (var i = 0; i <= 5; i++) {
      final y = size.height - (size.height * (i / 5));
      final labelText = (yLabelStep * i).toString();
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

    for (var i = 0; i < userWeights.length - 1; i++) {
      final x1 = i * 20.0;
      final y1 = size.height - (userWeights[i].weight! * size.height / maxY);
      final x2 = (i + 1) * 20.0;
      final y2 = size.height - (userWeights[i + 1].weight! * size.height / maxY);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}












class PressureChartBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BarChartGroupData>>(
      future: fetchData(), // Replace with your data-fetching function
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Loading indicator
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Container(
            width: 600,
            height: 300,
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
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  18.0, 18.0, 18.0, 16.0), // Adjust padding as needed
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Blood Pressure Chart',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color.fromARGB(255, 88, 119, 161),
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.left, // Align the text to the left
                  ),
                  SizedBox(height: 16.0), // Adjust spacing
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Future<List<BarChartGroupData>> fetchData() async {
    // Simulate fetching data from an API or database
    await Future.delayed(Duration(seconds: 2)); // Simulate a 2-second delay
    // Replace this with your actual data-fetching logic
    return [
      //BarChartGroupData(x: 1, barRods: [BarChartRodData(y: 150, color: Colors.blue)]),
      //BarChartGroupData(x: 2, barRods: [BarChartRodData(y: 152, color: Colors.blue)]),
      // ... add more data here
    ];
  }
}

class PressureChartView extends StatelessWidget {
  final List<BarChartGroupData>? data;

  PressureChartView({this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.white),
      ),
      child: BarChart(
        BarChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: data,
          barTouchData: BarTouchData(enabled: false),
          //axisTitleData: FlAxisTitleData(show: false),
          groupsSpace: 2,
        ),
      ),
    );
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
