import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thurula/services/local_service.dart';
import 'package:thurula/services/user_exercise_service.dart';
import 'package:thurula/models/user_exercise_model.dart';
import 'package:thurula/views/custom_loading_indicator.dart';

import 'package:thurula/views/pregnancy/pregnancy_exercises/pregnancy_exercise_recommendations_view.dart';

DateTime now = DateTime.now();
DateTime sevenDaysAgo = now.subtract(const Duration(days: 7));

class ExercisesHistoryView extends StatefulWidget {
  const ExercisesHistoryView({Key? key}) : super(key: key);

  @override
  _ExerciseHistorysViewState createState() => _ExerciseHistorysViewState();
}

class _ExerciseHistorysViewState extends State<ExercisesHistoryView> {
  late ValueNotifier<int> refreshCounter;
  late Future<String> userId;

  // list of user exercise
  late Future<List<UserExercise>> exerciseRecords;
  late Future<List<UserExercise>> last7DaysRecords;

  @override
  void initState() {
    super.initState();
    refreshCounter = ValueNotifier<int>(0); // Initialize the ValueNotifier
    _refreshData();
  }

  Future<void> _refreshData() async {
    userId = LocalService.getCurrentUserId();
    exerciseRecords =
        UserExerciseService.getUserExercises(await userId, null, null);
    // sort exerciseRecords by date
    exerciseRecords.then((value) => value.sort((a, b) => b.date!.compareTo(a.date!)));
    last7DaysRecords =
        UserExerciseService.getUserExercises(await userId, sevenDaysAgo, now);
    // sort last7DaysRecords by date
    last7DaysRecords.then((value) => value.sort((a, b) => b.date!.compareTo(a.date!)));
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
                        builder: (context) => PregnancyExercisesView()));
              },
            ),
            backgroundColor: const Color.fromARGB(255, 220, 104, 145),
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
              exerciseRecordTab(),
              exerciseRecordsAllTab()
              // const ExerciseRecordsAllTab(title: 'All Time'),
            ],
          ),
        ),
      ),
    );
  }

  Widget exerciseRecordTab() {
    return ValueListenableBuilder(
        valueListenable: refreshCounter,
        builder: (context, _, __) {
          return FutureBuilder<List<UserExercise>>(
            future: last7DaysRecords,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CustomLoadingIndicator();
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
                                        color:
                                            Color.fromARGB(255, 88, 119, 161)),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Duration (mins)',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 88, 119, 161)),
                                  )),
                                ],
                                rows: snapshot.data!
                                    // .take(7)
                                    .map(
                                      (record) => DataRow(
                                        cells: [
                                          DataCell(Text(
                                            // remove time and get only date
                                            record.date
                                                .toString()
                                                .substring(0, 10),
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 80, 78, 78)),
                                          )),
                                          DataCell(Text(
                                            record.minutesExercised.toString(),
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 80, 78, 78)),
                                          )),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
                              const SizedBox(height: 20),
                              // row inside card
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Text(
                                      'Total Exercise Duration:',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 220, 104, 145)),
                                    ),
                                    Text(
                                      '  ${calculateTotalDuration(snapshot.data!)} mins',
                                      // '  x mins',
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
        });
  }

  Widget exerciseRecordsAllTab() {
    return ValueListenableBuilder(
      valueListenable: refreshCounter,
      builder: (context, _, __) {
        return FutureBuilder<List<UserExercise>>(
          future: exerciseRecords,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CustomLoadingIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text('No records to show'),
              );
            } else {
              // Group the records by month
              final Map<String, List<UserExercise>> recordsByMonth = {};

              for (final record in snapshot.data!) {
                // Check if the record's date is not null
                if (record.date != null) {
                  final monthKey = DateFormat('MMMM yyyy').format(record.date!);
                  recordsByMonth.putIfAbsent(monthKey, () => []);
                  recordsByMonth[monthKey]!.add(record);
                }
              }

              // Get a list of unique month keys
              final monthKeys = recordsByMonth.keys.toList();

              return SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final monthKey in monthKeys)
                      Card(
                        elevation: 4.0,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ExpansionTile(
                          title: RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: monthKey,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 88, 119, 161)),
                                ),
                                TextSpan(
                                  text:
                                      '\n${calculateTotalMonthlyDuration(recordsByMonth[monthKey]!, monthKey)} mins',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 220, 104,
                                        145), // Change to the desired color for the rest of the text
                                  ),
                                ),
                              ],
                            ),
                          ),
                          children: [
                            DataTable(
                              columns: const [
                                DataColumn(
                                  label: Text(
                                    'Date',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 88, 119, 161),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Duration (mins)',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 88, 119, 161),
                                    ),
                                  ),
                                ),
                              ],
                              rows: recordsByMonth[monthKey]!
                                  .map(
                                    (record) => DataRow(
                                      cells: [
                                        DataCell(Text(
                                          // Check if the date is not null
                                          record.date != null
                                              ? record.date
                                                  .toString()
                                                  .substring(0, 10)
                                              : '',
                                          style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 80, 78, 78),
                                          ),
                                        )),
                                        DataCell(Text(
                                          record.minutesExercised.toString(),
                                          style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 80, 78, 78),
                                          ),
                                        )),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            }
          },
        );
      },
    );
  }

  calculateTotalDuration(List<UserExercise> records) {
    int total = 0;
    //   first 7 records
    for (var record in records.take(7)) {
      total += record.minutesExercised!;
    }
    return total;
  }

  calculateTotalMonthlyDuration(List<UserExercise> records, String month) {
    int total = 0;
    for (var record in records) {
      if (record.date != null) {
        if (DateFormat('MMMM yyyy').format(record.date!) == month) {
          total += record.minutesExercised!;
        }
      }
    }
    // print to console
    return total;
  }
}

class ExerciseRecord {
  final String date;
  final int duration;
  final int? week;

  ExerciseRecord({required this.date, required this.duration, this.week});
}
