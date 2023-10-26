import 'package:flutter/material.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_1.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_10.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_11.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_12.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_13.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_14.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_2.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_3.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_4.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_5.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_6.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_7.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_8.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_9.dart';

var week = 5; // Todo: Get the week-1 to open the respective tab

class PregnancyTimelineView extends StatelessWidget {
  const PregnancyTimelineView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        initialIndex: week,
        length: 14,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 247, 247, 247),
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 220, 104, 145),
            // backgroundColor: const Color.fromARGB(255, 227, 227, 227),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              onPressed: () {
                // Handle back button press here
                Navigator.of(context).pop(); // Example: Navigate back
              },
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50.0), // height of  TabBar
              child: Container(
                color: const Color.fromARGB(255, 220, 104, 145),
                child: const TabBar(
                  isScrollable: true,
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
                    ),
                    Tab(
                      text: "Week 5",
                    ),
                    Tab(
                      text: "Week 6",
                    ),
                    Tab(
                      text: "Week 7",
                    ),
                    Tab(
                      text: "Week 8",
                    ),
                    Tab(
                      text: "Week 9",
                    ),
                    Tab(
                      text: "Week 10",
                    ),
                    Tab(
                      text: "Week 11",
                    ),
                    Tab(
                      text: "Week 12",
                    ),
                    Tab(
                      text: "Week 13",
                    ),
                    Tab(
                      text: "Week 14",
                    ),
                  ],
                  indicatorColor: Colors.white,
                ),
              ),
            ),
            title: const Text(
              'Pregnancy Timeline',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
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
              // Week 5
              Week5View(),
              // Week 6
              Week6View(),
              // Week 7
              Week7View(),
              // Week 8
              Week8View(),
              // Week 9
              Week9View(),
              // Week 10
              Week10View(),
              // Week 11
              Week11View(),
              // Week 12
              Week12View(),
              // Week 13
              Week13View(),
              // Week 14
              Week14View(),
            ],
          ),
        ),
      ),
    );
  }
}
