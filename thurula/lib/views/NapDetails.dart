import 'package:flutter/material.dart';
import 'package:thurula/views/NapTimer.dart';
import 'package:thurula/views/AddNap.dart';
import 'package:thurula/views/MenuView.dart';


class NapDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Baby Nap Details'),
        // centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MenuView()),
            );
          },
        ),
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
                  style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 220, 104, 145),),
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
                  style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 220, 104, 145),),
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
          color: Colors.blue,
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
                color: const Color.fromARGB(255, 220, 104, 145),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
