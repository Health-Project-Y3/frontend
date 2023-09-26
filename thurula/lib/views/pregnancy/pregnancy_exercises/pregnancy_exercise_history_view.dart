import 'package:flutter/material.dart';
import 'package:thurula/views/pregnancy/pregnancy_exercises/pregnancy_exercise_recommendations_view.dart';

class ExercisesHistoryView extends StatelessWidget {
  const ExercisesHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ExercisesView()));
              },
            ),
            backgroundColor: const Color.fromARGB(255, 220, 104, 145),
            // back button

            title: const Text(
              'Exercise History',
            ),

            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48.0),
              child: Container(
                  color: const Color.fromARGB(255, 220, 104, 145),
                  child: const TabBar(
                    indicatorColor: Colors.white,
                    isScrollable: true,
                    tabs: [
                      Tab(
                        text: "Last 7 Days",
                      ),
                      // Tab(
                      //   text: "Last Month",
                      // ),
                      Tab(
                        text: "All Time",
                      )
                    ],
                  )),
            ),
          ),

          // add title to page
          // body: TabBarView(
          //   children: [
          //     // First Trimester
          //     SingleChildScrollView(
          //       child: Column(
          //         children: [
          //           // padding
          //           Padding(
          //             padding: const EdgeInsets.only(right: 30, top: 20),
          //             // calories and time
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.end,
          //               children: <Widget>[
          //                 // calories
          //                 Image.asset(
          //                     'assets/images/icons/calories.png',
          //                     height: 20,
          //                     width: 20
          //                 ),
          //                 const Text(
          //                   " 55 kcal",
          //                   style: TextStyle(
          //                     fontSize: 16,
          //                     // fontWeight: FontWeight.bold,
          //                     fontFamily: 'Inter',
          //                     //   color #878787
          //                     color: Color.fromARGB(255, 131, 131, 131),
          //                   ),
          //                 ),
          //
          //                 // time
          //                 Container(width: 20),
          //                 Image.asset(
          //                     'assets/images/icons/clock.png',
          //                     height: 20,
          //                     width: 20
          //                 ),
          //                 const Text(
          //                   " 10 min",
          //                   style: TextStyle(
          //                     fontSize: 16,
          //                     // fontWeight: FontWeight.bold,
          //                     fontFamily: 'Inter',
          //                     //   color #878787
          //                     color: Color.fromARGB(255, 131, 131, 131),
          //                   ),
          //                 ),
          //
          //                 Container(width: 150),
          //
          //                 // achievement
          //                 GestureDetector(
          //                   onTap: () {
          //                     // show congratulations alert
          //                     showDialog(
          //                         context: context,
          //                         builder: (BuildContext context) {
          //                           //   alert dialog with an image and text
          //                           return AlertDialog(
          //                             title: const Text(
          //                               // center align
          //                               textAlign: TextAlign.center,
          //                               "Congratulations! You have worked out for 15 minutes today...",
          //                               style: TextStyle(
          //                                 fontSize: 20,
          //                                 fontWeight: FontWeight.bold,
          //                                 fontFamily: 'Inter',
          //                                 color: Color.fromARGB(255, 220, 104, 145),
          //                               ),
          //                             ),
          //                             content: Image.asset(
          //                               'assets/images/icons/trophy.jpg',
          //                               width: 100,
          //                               fit: BoxFit.cover,
          //                             ),
          //                             actions: <Widget>[
          //                               TextButton(
          //                                 onPressed: () {
          //                                   Navigator.of(context).pop();
          //                                 },
          //                                 child: const Text(
          //                                   "OK",
          //                                   style: TextStyle(
          //                                     fontSize: 20,
          //                                     fontWeight: FontWeight.bold,
          //                                     fontFamily: 'Inter',
          //                                     //   color #504E4E
          //                                     color: Color.fromARGB(
          //                                         255, 80, 78, 78),
          //                                   ),
          //                                 ),
          //                               ),
          //                             ],
          //                           );
          //                         });
          //                   },
          //                   child: const Image(
          //                     image: AssetImage(
          //                         'assets/images/icons/crown.png'),
          //                     width: 25,
          //                   ),
          //                 ),
          //
          //               ],
          //             ),
          //           ),
          //
          //           // Exercise cards
          //           for(int x = 1; x<=5; x++)...[
          //             Container(height: 10),
          //             Padding(
          //                 padding: const EdgeInsets.only(
          //                   left: 20.0,
          //                   right: 20.0,
          //                 ),
          //                 child: Text(
          //                   "TBD"
          //                 )
          //             ),
          //
          //           ],
          //
          //
          //
          //         ],
          //       ),
          //     ),
          //   ],
          // ),

          body: TabBarView(
            children: [
              ExerciseRecordsTab(title: 'Last 7 Days'),
              // ExerciseRecordsTab(title: 'Last Month'),
              ExerciseRecordsAllTab(title: 'All Time'),
            ],
          ),

        ),
      ),
    );
  }
}

class ExerciseRecordsTab extends StatelessWidget {
  final String title;

  ExerciseRecordsTab({required this.title});

  @override
  Widget build(BuildContext context) {
    // Mock data for demonstration
    final List<ExerciseRecord> exerciseRecords = [
      ExerciseRecord(date: '2023-09-25', duration: 30),
      ExerciseRecord(date: '2023-09-20', duration: 45),
      // Add more exercise records here
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   title,
          //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          // ),
          // SizedBox(height: 10),
          DataTable(
            columns: [
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Duration (minutes)')),
            ],
            rows: exerciseRecords
                .map(
                  (record) => DataRow(
                cells: [
                  DataCell(Text(record.date)),
                  DataCell(Text(record.duration.toString())),
                ],
              ),
            )
                .toList(),
          ),
          SizedBox(height: 20),
          Text(
            'Total Exercise Duration:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            '${calculateTotalDuration(exerciseRecords)} minutes',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  int calculateTotalDuration(List<ExerciseRecord> records) {
    return records.map((record) => record.duration).fold(0, (a, b) => a + b);
  }
}

class ExerciseRecord {
  final String date;
  final int duration;

  ExerciseRecord({required this.date, required this.duration});
}


class ExerciseRecordsAllTab extends StatelessWidget {
  final String title;

  ExerciseRecordsAllTab({required this.title});

  @override
  Widget build(BuildContext context) {
    // Mock data for demonstration
    final List<ExerciseRecord> exerciseRecords = [
      ExerciseRecord(date: '2023-09-25', duration: 30),
      ExerciseRecord(date: '2023-09-20', duration: 45),
      ExerciseRecord(date: '2023-08-15', duration: 60),
      ExerciseRecord(date: '2023-08-10', duration: 40),
      ExerciseRecord(date: '2023-07-28', duration: 55),
      // Add more exercise records here
    ];

    // Group exercise records by month
    final Map<String, List<ExerciseRecord>> recordsByMonth = {};

    for (var record in exerciseRecords) {
      final yearMonth = record.date.substring(0, 7);
      if (!recordsByMonth.containsKey(yearMonth)) {
        recordsByMonth[yearMonth] = [];
      }
      recordsByMonth[yearMonth]!.add(record);
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   title,
          //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          // ),
          SizedBox(height: 10),
          // Display records grouped by month in cards
          ...recordsByMonth.entries.map((entry) {
            final month = entry.key;
            final records = entry.value;
            return Card(
              elevation: 4.0,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      month,
                      style:
                      TextStyle(fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 88, 119, 161)

                      ),
                    ),
                    SizedBox(height: 8.0),
                    DataTable(
                      columns: [
                        DataColumn(label: Text('Week')),
                        DataColumn(label: Text('Duration (minutes)')),
                      ],
                      rows: records
                          .map(
                            (record) => DataRow(
                          cells: [
                            DataCell(Text(record.date)),
                            DataCell(Text(record.duration.toString())),
                          ],
                        ),
                      )
                          .toList(),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Total Duration:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '  ${calculateTotalDuration(records)} minutes',
                          style: TextStyle(fontSize: 18),
                        ),
                      ]
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  int calculateTotalDuration(List<ExerciseRecord> records) {
    return records.map((record) => record.duration).fold(0, (a, b) => a + b);
  }
}
