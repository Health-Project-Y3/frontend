import 'package:flutter/material.dart';
import 'package:thurula/views/childcare/nap/nap_timer.dart';
import 'package:thurula/views/childcare/nap/add_nap.dart';
import 'package:thurula/views/childcare/nap/nap_records.dart';
import 'package:thurula/views/childcare/child_home_view.dart';

class NapDetails extends StatelessWidget {
  const NapDetails({super.key});

  Future<Map<String, double>> fetchSleepHours() async {
    // Simulating fetching sleep hour data from an API or database
    await Future.delayed(const Duration(seconds: 2));
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
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
        title: const Text(
          'Baby Nap Details',
          style: TextStyle(
            color: Colors.white, // Title color
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white, // Back icon color
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChildHomeView()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Center(
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/sleeping_image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  "Mary's Nap Details",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 88, 119, 161),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NapTimer()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 220, 104, 145),
                    ),
                    child: const Text('Nap Timer'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddNap()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 220, 104, 145),
                    ),
                    child: const Text('Add Nap'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Row(
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
              const SizedBox(height: 2),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NapRecords()), // Replace with your actual widget name
                      );
                    },
                    child: const Text(
                      'All Nap Details',
                      style: TextStyle(
                        color: Color.fromARGB(255, 220, 104, 145),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),

              // Bar Chart
              const SizedBox(height: 16),
              SizedBox(
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
  List<String> days = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ]; // Days of the week

  for (int i = 0; i < 7; i++) {
    double barHeight = (i + 1) * 30.0; // Vary the height for each bar
    bars.add(
      Container(
        width: 20,
        padding: const EdgeInsets.all(20),
        height: barHeight,
        color: const Color.fromARGB(255, 88, 119, 161),
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
          SizedBox(
            height: 170,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: 50,
                  height: 100,
                  color: Colors.transparent,
                ),
                bars[i],
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            days[i],
            style: const TextStyle(fontSize: 12),
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

  const NapStatCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 220, 104, 145),
              ),
            ),
          ],
        ),
      ),
    );
  }
}