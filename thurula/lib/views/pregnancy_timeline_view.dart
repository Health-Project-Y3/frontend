import 'package:flutter/material.dart';
import 'package:thurula/views/pregnancy_timline/week_1.dart';
import 'package:thurula/views/pregnancy_timline/week_2.dart';
import 'package:thurula/views/pregnancy_timline/week_3.dart';
import 'package:thurula/views/pregnancy_timline/week_4.dart';

class PregnancyTimelineView extends StatelessWidget {
  const PregnancyTimelineView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 227, 227, 227),
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 227, 227, 227),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color.fromARGB(255, 88, 119, 161),
              ),
              onPressed: () {
                // Handle back button press here
                Navigator.of(context).pop(); // Example: Navigate back
              },
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50.0), // height of  TabBar
              child: Container(
                color: Color.fromARGB(255, 220, 104, 145),
                child: const TabBar(
                  tabs: [
                    Tab(
                      text: "Week 1",
                    ),
                    Tab(
                      text: "Week 2",
                    ),
                    Tab(
                      text: "Week 3",
                    ),
                    Tab(
                      text: "Week 4",
                    )
                  ],
                ),
              ),
            ),
            title: const Text(
              'Pregnancy Timeline',
              style: TextStyle(
                color: Color.fromARGB(255, 88, 119, 161),
              ),
            ),
          ),
          body: const TabBarView(
            children: [
              Week1View(),
              // Week 2
              Week2View(),
              // Week 3
              Week3View(),

              // Week 4
              Week4View(),
            ],
          ),
        ),
      ),
    );
  }
}
