import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:thurula/views/pregnancy/prepregnancy_details.dart';
import 'package:thurula/views/pregnancy/add_weight.dart';
import 'package:thurula/views/pregnancy/add_pressure.dart';
import 'package:thurula/views/pregnancy/add_water.dart';
import 'package:thurula/services/auth/user_service.dart';
import 'package:thurula/models/user_model.dart';
import 'package:thurula/services/auth/user_service.dart';



class MotherHealthTracker1 extends StatefulWidget {
  const MotherHealthTracker1({Key? key}) : super(key: key);

  @override
  _HealthTrackerState createState() => _HealthTrackerState();
}

class _HealthTrackerState extends State<MotherHealthTracker1> {
  bool isModalOpen = false;

  @override
  void initState() {
    super.initState();

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
                                  // Box 1
                                  FutureBuilder<User?>(
                                    future: UserService.getUser('652a5d43935d40f339c12d8b'), // Replace with the actual user ID
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return CircularProgressIndicator(); // Display loading indicator while fetching data
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else {
                                        // No user data or weight is 0
                                        final double userWeight = snapshot.data!.preWeight!;
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
                                              padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 6.0),
                                              child: Text(
                                                '${userWeight.toStringAsFixed(1)} Kg', // Display the fetched user weight as a double
                                                style: TextStyle(
                                                  color: Color.fromARGB(255, 88, 119, 161),
                                                  fontSize: 36.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 2.0),
                                              child: Text(
                                                'Week on Week Gain - 1.5kg', // Update with the actual gain value
                                                style: TextStyle(
                                                  color: Color.fromARGB(255, 88, 119, 161),
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                  )
                                ],
                              ),
                            )
                            ,
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
                      WeightChartBox(),
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
                    'Your Weight Chart',
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

class WeightChartView extends StatelessWidget {
  final List<BarChartGroupData>? data;

  WeightChartView({this.data});

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
    heightController.text = 'Initial Height Value'; // Replace with your initial value
    weightController.text = 'Initial Weight Value'; // Replace with your initial value
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
                        UserService.updateUser('651565c2e11d243e01ee0565', updatedUser)
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


