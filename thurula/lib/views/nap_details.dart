import 'package:flutter/material.dart';
import 'package:thurula/views/nap_timer.dart';
import 'package:thurula/views/add_nap.dart';
import 'package:thurula/views/nap_records.dart';
import 'package:thurula/views/child_home_view.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class NapDetails extends StatelessWidget {
  Future<Map<String, double>> fetchSleepHours() async {
    // Simulating fetching sleep hour data from an API or database
    await Future.delayed(Duration(seconds: 2));
    return {
      'Mon': 12,
      'Tue': 13,
      'Wed': 12,
      'Thu': 14,
      'Fri': 16,
      'Sat': 11,
      'Sun': 13
    }; // Sleep hour data for each day
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Baby Nap Details',
          style: TextStyle(
            color: const Color.fromARGB(255, 220, 104, 145), // Title color
          ),
        ),
        backgroundColor: Colors.white, // Background color of the app bar
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: const Color.fromARGB(255, 220, 104, 145), // Back icon color
          ),
          onPressed: () {
            // Handle back button press here
            Navigator.pop(context); // This should navigate back correctly
          },
        ),
      ),


      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16),
              Center(
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/sleeping_image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: Text(
                  "Mary's Nap Details",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NapTimer()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 220, 104, 145),
                    ),
                    child: Text('Nap Timer'),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddNap()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 220, 104, 145),
                    ),
                    child: Text('Add Nap'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: NapStatCard(
                      title: 'Total Naps',
                      value: '7',
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: NapStatCard(
                      title: 'Total Sleep Hours',
                      value: '35',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NapRecords()), // Replace with your actual widget name
                      );
                    },
                    child: Text(
                      'All Nap Details',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 220, 104, 145),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),

              // Bar Chart
              SizedBox(height: 16),
              Container(
                height: 300,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: buildBarChart(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> buildBarChart() {
  List<Widget> bars = [];
  List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']; // Days of the week

  for (int i = 0; i < 7; i++) {
    double barHeight = (i + 1) * 30.0; // Vary the height for each bar

    bars.add(
      Container(
        width: 20,
        padding: EdgeInsets.all(20),
        height: barHeight,
        color: Colors.pink,
      ),
    );
  }

  List<Widget> chartContent = [];

  // Y-Axis labels

  // Bars and X-Axis labels
  for (int i = 0; i < bars.length; i++) {
    chartContent.add(
      Column(
        children: [
          Container(
            height: 170,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: 65,
                  height: 100,
                  color: Colors.transparent,
                ),
                bars[i],
              ],
            ),
          ),
          SizedBox(height: 4),
          Text(
            days[i],
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  return chartContent;
}

class NapStatCard extends StatelessWidget {
  final String title;
  final String value;

  NapStatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 220, 104, 145),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
