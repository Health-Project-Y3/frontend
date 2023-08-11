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
        title: Text('Baby Nap Details'),
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press here
            Navigator.of(context).pop(); // Example: Navigate back
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
              SizedBox(height: 4),
              // Container(
              //   height: 200,
              //   child: FutureBuilder<Map<String, double>>(
              //     future: fetchSleepHours(),
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return Center(child: CircularProgressIndicator());
              //       } else if (snapshot.hasError) {
              //         return Center(child: Text('Error: ${snapshot.error}'));
              //       } else if (!snapshot.hasData) {
              //         return Center(child: Text('No data available.'));
              //       }
              //
              //       final List<FlSpot> spots =
              //           snapshot.data!.entries.map((entry) {
              //         final dayIndex = [
              //           'Mon',
              //           'Tue',
              //           'Wed',
              //           'Thu',
              //           'Fri',
              //           'Sat',
              //           'Sun'
              //         ].indexOf(entry.key);
              //         return FlSpot(dayIndex.toDouble(), entry.value);
              //       }).toList();
              //
              //       return LineChart(
              //         LineChartData(
              //           gridData: FlGridData(show: false),
              //           titlesData: FlTitlesData(
              //             topTitles: SideTitles(showTitles: false),
              //             leftTitles: SideTitles(showTitles: true),
              //
              //             bottomTitles: SideTitles(
              //               showTitles: true,
              //               getTitles: (value) {
              //                 final daysOfWeek = [
              //                   'Mon',
              //                   'Tue',
              //                   'Wed',
              //                   'Thu',
              //                   'Fri',
              //                   'Sat',
              //                   'Sun'
              //                 ];
              //                 if (value >= 0 && value < daysOfWeek.length) {
              //                   return daysOfWeek[value.toInt()];
              //                 }
              //                 return '';
              //               },
              //             ),
              //           ),
              //           borderData: FlBorderData(show: true),
              //           minX: 0,
              //           maxX: 6,
              //           minY: 0,
              //           maxY: snapshot.data!.values.reduce(
              //                   (max, value) => max > value ? max : value) +
              //               2,
              //           lineBarsData: [
              //             LineChartBarData(
              //               spots: spots,
              //               colors: [Colors.blue],
              //               isCurved: true,
              //               dotData: FlDotData(show: true),
              //             ),
              //           ],
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// class LineChartPainter extends StatelessWidget {
//   final List<double> sleepHours;

  // LineChartPainter(this.sleepHours);
  //
  // @override
  // Widget build(BuildContext context) {
  //   final List<FlSpot> spots = sleepHours.asMap().entries.map((entry) {
  //     return FlSpot(entry.key.toDouble(), entry.value);
  //   }).toList();

    // return LineChart(
    //   LineChartData(
    //     gridData: FlGridData(show: false),
    //     titlesData: FlTitlesData(
    //       leftTitles: SideTitles(showTitles: true),
    //       bottomTitles: SideTitles(showTitles: true),
    //     ),
    //     borderData: FlBorderData(show: true),
    //     minX: 0,
    //     maxX: sleepHours.length.toDouble() - 1,
    //     minY: 0,
    //     maxY: sleepHours.reduce((max, value) => max > value ? max : value),
    //     lineBarsData: [
    //       LineChartBarData(
    //         spots: spots,
    //         colors: [Colors.blue],
    //         isCurved: true,
    //         dotData: FlDotData(show: true),
    //       ),
    //     ],
    //   ),
    // );
//   }
// }

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
