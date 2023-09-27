import 'package:flutter/material.dart';
// import 'package:thurula/views/pregnancy/pregnancy_exercises/pregnancy_exercise_recommendations_view.dart';
import 'package:intl/intl.dart';
import 'package:thurula/views/pregnancy/pregnancy_exercises/pregnancy_exercise_recommendations_view.dart';

import 'package:thurula/services/local_service.dart';
import 'package:thurula/services/user_exercise_service.dart';
import 'package:thurula/models/user_exercise_model.dart';

DateTime now = DateTime.now();
DateTime sevenDaysAgo = now.subtract(Duration(days: 7));

class ExercisesHistoryView extends StatefulWidget {
  const ExercisesHistoryView({Key? key}) : super(key: key);

  @override
  _ExerciseHistorysViewState createState() => _ExerciseHistorysViewState();
}

class _ExerciseHistorysViewState extends State<ExercisesHistoryView> {
  late ValueNotifier<int> refreshCounter;
  late Future<String> userId;
  // list of userexercise
  late Future<List<UserExercise>> exerciseRecords;

  @override
  void initState() {
    super.initState();
    refreshCounter = ValueNotifier<int>(0); // Initialize the ValueNotifier
    _refreshData();
  }

  Future<void> _refreshData() async {
    userId = LocalService.getCurrentUserId();
    exerciseRecords = UserExerciseService.getUserExercises(await userId, null, null);
    // Increment the refresh counter to trigger UI update
    refreshCounter.value++;
  }

  @override
  void dispose() {
    refreshCounter.dispose(); // Dispose the ValueNotifier
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
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
                      Tab(
                        text: "All Time",
                      )
                    ],
                  )),
            ),
          ),

          body: TabBarView(
            children: [
              ExerciseRecordTab(),
              const ExerciseRecordsAllTab(title: 'All Time'),
            ],
          ),
        ),
      ),
    );
  }

  Widget ExerciseRecordTab() {
    return ValueListenableBuilder(
        valueListenable: refreshCounter,
        builder: (context, _, __) {
          return FutureBuilder<List<UserExercise>>(
            future: exerciseRecords,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return const Center(
                  child: Text('No records to show'),
                );
              } else {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 4.0,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DataTable(
                                columns: const [
                                  DataColumn(
                                      label: Text(
                                        'Date',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 88, 119, 161)),
                                      )),
                                  DataColumn(
                                      label: Text(
                                        'Duration (mins)',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 88, 119, 161)),
                                      )),
                                ],
                                rows: snapshot.data!
                                    .map(
                                      (record) => DataRow(
                                    cells: [
                                      DataCell(Text(
                                        // remove time and get only date
                                        record.date.toString().substring(0, 10),
                                        style: const TextStyle(
                                            color: Color.fromARGB(255, 80, 78, 78)),
                                      )),
                                      DataCell(Text(
                                        record.minutesExercised.toString(),
                                        style: const TextStyle(
                                            color: Color.fromARGB(255, 80, 78, 78)),
                                      )),
                                    ],
                                  ),
                                )
                                    .toList(),
                              ),
                              const SizedBox(height: 20),
                              // row inside card
                              Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                                const Text(
                                  'Total Exercise Duration:',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 220, 104, 145)),
                                ),
                                Text(
                                  // '  ${calculateTotalDuration(snapshot.data!)} mins',
                                  '  calculateTotalDuration mins',
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ]),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          );
        }
    );
  }
}

// class ExerciseRecordsTab extends StatelessWidget {
//   final String title;
//
//   const ExerciseRecordsTab({super.key, required this.title});
//
//   @override
//   Widget build(BuildContext context) {
//     // Mock data for demonstration
//     final List<ExerciseRecord> exerciseRecords = [
//       ExerciseRecord(date: '2023-09-25', duration: 30),
//       ExerciseRecord(date: '2023-09-24', duration: 45),
//       ExerciseRecord(date: '2023-09-23', duration: 0),
//       ExerciseRecord(date: '2023-09-22', duration: 45),
//       ExerciseRecord(date: '2023-09-21', duration: 0),
//       ExerciseRecord(date: '2023-09-20', duration: 45),
//       ExerciseRecord(date: '2023-09-19', duration: 45),
//     ];
//
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(20.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Card(
//             elevation: 4.0,
//             margin: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   DataTable(
//                     columns: const [
//                       DataColumn(
//                           label: Text(
//                         'Date',
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Color.fromARGB(255, 88, 119, 161)),
//                       )),
//                       DataColumn(
//                           label: Text(
//                         'Duration (mins)',
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Color.fromARGB(255, 88, 119, 161)),
//                       )),
//                     ],
//                     rows: exerciseRecords
//                         .map(
//                           (record) => DataRow(
//                             cells: [
//                               DataCell(Text(
//                                 record.date,
//                                 style: const TextStyle(
//                                     color: Color.fromARGB(255, 80, 78, 78)),
//                               )),
//                               DataCell(Text(
//                                 record.duration.toString(),
//                                 style: const TextStyle(
//                                     color: Color.fromARGB(255, 80, 78, 78)),
//                               )),
//                             ],
//                           ),
//                         )
//                         .toList(),
//                   ),
//                 const SizedBox(height: 20),
//                 // row inside card
//                 Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
//                   const Text(
//                     'Total Exercise Duration:',
//                     style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Color.fromARGB(255, 220, 104, 145)),
//                   ),
//                   Text(
//                     '  ${calculateTotalDuration(exerciseRecords)} mins',
//                     style: const TextStyle(fontSize: 18),
//                   ),
//                 ]),
//                 ])),
//           ),
//         ],
//       ),
//     );
//   }
//
//   int calculateTotalDuration(List<ExerciseRecord> records) {
//     return records.map((record) => record.duration).fold(0, (a, b) => a + b);
//   }
// }

class ExerciseRecord {
  final String date;
  final int duration;
  final int? week;

  ExerciseRecord({required this.date, required this.duration, this.week});
}

class ExerciseRecordsAllTab extends StatelessWidget {
  final String title;

  const ExerciseRecordsAllTab({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // Mock data
    final List<ExerciseRecord> exerciseRecords = [
      ExerciseRecord(date: '2023-09-22', week:4, duration: 30),
      ExerciseRecord(date: '2023-09-15', week:3, duration: 45),
      ExerciseRecord(date: '2023-09-08', week:2, duration: 45),
      ExerciseRecord(date: '2023-09-01', week:1, duration: 45),
      ExerciseRecord(date: '2023-08-22', week:4, duration: 30),
      ExerciseRecord(date: '2023-08-15', week:3, duration: 45),
      ExerciseRecord(date: '2023-08-08', week:2, duration: 45),
      ExerciseRecord(date: '2023-08-01', week:1, duration: 45),
      ExerciseRecord(date: '2023-07-22', week:4, duration: 30),
      ExerciseRecord(date: '2023-07-15', week:3, duration: 45),
      ExerciseRecord(date: '2023-07-08', week:2, duration: 45),
      ExerciseRecord(date: '2023-07-01', week:1, duration: 45),
    ];

    // Group exercise records by month
    final Map<String, List<ExerciseRecord>> recordsByMonth = {};

    for (var record in exerciseRecords) {
      final yearMonth = record.date.substring(5, 7);
      if (!recordsByMonth.containsKey(yearMonth)) {
        recordsByMonth[yearMonth] = [];
      }
      recordsByMonth[yearMonth]!.add(record);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          // Display records grouped by month in cards
          ...recordsByMonth.entries.map((entry) {
            final month = entry.key;
            int monthInt = int.parse(month);
            DateTime dateTime = DateTime(2023, monthInt, 1);
            String monthName = DateFormat('MMMM').format(dateTime);

            final records = entry.value;

            return Card(
              elevation: 4.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      monthName,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 88, 119, 161)),
                    ),
                    const SizedBox(height: 8.0),
                    DataTable(
                      columns: const [
                        DataColumn(
                            label: Text(
                          'Week',
                          style: TextStyle(
                              color: Color.fromARGB(255, 88, 119, 161)),
                        )),
                        DataColumn(
                            label: Text(
                          'Duration (mins)',
                          style: TextStyle(
                              color: Color.fromARGB(255, 88, 119, 161)),
                        )),
                      ],
                      rows: records
                          .map(
                            (record) => DataRow(
                              cells: [
                                DataCell(Text(
                                  "Week ${record.week}",
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 80, 78, 78)),
                                )),
                                DataCell(Text(
                                    record.duration.toString()
                                )),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          const Text(
                            'Total Duration:',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 220, 104, 145)),
                          ),
                          Text(
                            '  ${calculateTotalDuration(records)} mins',
                            style: const TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 220, 104, 145)),
                          ),
                        ])
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


