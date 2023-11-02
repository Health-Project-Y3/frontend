import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_1.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_10.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_11.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_12.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_13.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_14.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_15.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_16.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_17.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_18.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_19.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_2.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_20.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_21.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_22.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_23.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_24.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_25.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_26.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_27.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_28.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_29.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_3.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_30.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_31.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_32.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_33.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_34.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_35.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_36.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_37.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_38.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_39.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_4.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_40.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_5.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_6.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_7.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_8.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline/week_9.dart';
import 'package:thurula/providers/user_provider.dart';

import '../widgets/navbar_widget.dart';

class PregnancyTimelineView extends StatelessWidget {
  const PregnancyTimelineView({super.key});

  @override
  Widget build(BuildContext context) {
    final int week = CalculateCurrentWeek(context);
    return MaterialApp(
      home: DefaultTabController(
        initialIndex: week,
        length: 40,
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
                    Tab(
                      text: "Week 15",
                    ),
                    Tab(
                      text: "Week 16",
                    ),
                    Tab(
                      text: "Week 17",
                    ),
                    Tab(
                      text: "Week 18",
                    ),
                    Tab(
                      text: "Week 19",
                    ),
                    Tab(
                      text: "Week 20",
                    ),
                    Tab(
                      text: "Week 21",
                    ),
                    Tab(
                      text: "Week 22",
                    ),
                    Tab(
                      text: "Week 23",
                    ),
                    Tab(
                      text: "Week 24",
                    ),
                    Tab(
                      text: "Week 25",
                    ),
                    Tab(
                      text: "Week 26",
                    ),
                    Tab(
                      text: "Week 27",
                    ),
                    Tab(
                      text: "Week 28",
                    ),
                    Tab(
                      text: "Week 29",
                    ),
                    Tab(
                      text: "Week 30",
                    ),
                    Tab(
                      text: "Week 31",
                    ),
                    Tab(
                      text: "Week 32",
                    ),
                    Tab(
                      text: "Week 33",
                    ),
                    Tab(
                      text: "Week 34",
                    ),
                    Tab(
                      text: "Week 35",
                    ),
                    Tab(
                      text: "Week 36",
                    ),
                    Tab(
                      text: "Week 37",
                    ),
                    Tab(
                      text: "Week 38",
                    ),
                    Tab(
                      text: "Week 39",
                    ),
                    Tab(
                      text: "Week 40",
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
              // Week 1
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
              // Week 15
              Week15View(),
              // Week 16
              Week16View(),
              // Week 17
              Week17View(),
              // Week 18
              Week18View(),
              // Week 19
              Week19View(),
              // Week 20
              Week20View(),
              // Week 21
              Week21View(),
              // Week 22
              Week22View(),
              // Week 23
              Week23View(),
              // Week 24
              Week24View(),
              // Week 25
              Week25View(),
              // Week 26
              Week26View(),
              // Week 27
              Week27View(),
              // Week 28
              Week28View(),
              // Week 29
              Week29View(),
              // Week 30
              Week30View(),
              // Week 31
              Week31View(),
              // Week 32
              Week32View(),
              // Week 33
              Week33View(),
              // Week 34
              Week34View(),
              // Week 35
              Week35View(),
              // Week 36
              Week36View(),
              // Week 37
              Week37View(),
              // Week 38
              Week38View(),
              // Week 39
              Week39View(),
              // Week 40
              Week40View(),
            ],
          ),
          bottomNavigationBar: const CreateBottomNavigationBar(pageIndex: 1),
        ),
      ),
    );
  }
}

int CalculateCurrentWeek(BuildContext context) {
  DateTime? dueDate = context.read<UserProvider>().user?.dueDate;

  if (dueDate != null) {
    final currentDate = DateTime.now();
    final difference = dueDate.difference(currentDate);
    final remainingWeeks = (difference.inDays / 7).ceil();
    int week = 40 - remainingWeeks;
    return week;
  }

  return 0; // If there's no due date available
}
