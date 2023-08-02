import 'package:flutter/material.dart';

void main() => runApp(BabyCareApp());

class BabyCareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baby Nap Dashboard'),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
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
                    image: AssetImage('images/pic.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                "Adeepa's Nap Details",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Implement the action for adding nap details
                },
                style: ElevatedButton.styleFrom(primary: Colors.pink),
                child: Text('Add Nap'),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: NapStatCard(
                    title: 'Total Naps',
                    value: '7', // Change this value to match your data
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: NapStatCard(
                    title: 'Total Sleep Hours',
                    value: '35', // Change this value to match your data
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              height: 300,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: buildBarChart(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
                color: Colors.pink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
