import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thurula/services/local_service.dart';
import 'package:thurula/services/vaccination_service.dart';
import 'package:thurula/models/vaccination_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../services/notification_service.dart';

class VaccinationTrackerView extends StatefulWidget {
  const VaccinationTrackerView({super.key});

  @override
  _VaccinationTrackerViewState createState() => _VaccinationTrackerViewState();
}

class _VaccinationTrackerViewState extends State<VaccinationTrackerView> {
  late ValueNotifier<int> refreshCounter;
  late Future<List<Vaccination>> upcomingVaccinations;
  late Future<List<Vaccination>> completedVaccinations;
  late Future<String> babyId;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  Timer? notificationTimer;
  int daysToNotify = 5;
  // late final NotificationService NotificationService;

  @override
  void initState() {
    super.initState();

    babyId = LocalService.getCurrentBabyId();
    refreshCounter = ValueNotifier<int>(0); // Initialize the ValueNotifier
    _refreshData();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    NotificationService.initialize(flutterLocalNotificationsPlugin);
    notificationTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      checkOverdueCondition();
    });
    // checkOverdueCondition();
  }

  void checkOverdueCondition() {
    // Replace this with your logic to calculate the difference
    int difference = calculateDifference();

    if (difference < 0 && daysToNotify > 0) {
      NotificationService.showOverdueNotification(
          fln: flutterLocalNotificationsPlugin);
      daysToNotify--;
    }
  }

  int calculateDifference() {
    // Calculate the difference here (e.g., compare with today's date)
    // Return the difference in days
    return -1;
  }

  Future<void> _refreshData() async {
    final babyIdValue = "650fe71a1953bf17d815fac4";
    // final babyIdValue = await babyId;
    // print(babyIdValue);
    upcomingVaccinations =
        VaccinationService.getDueBabyVaccinations(babyIdValue);
    completedVaccinations =
        VaccinationService.getCompletedBabyVaccinations(babyIdValue);
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
          backgroundColor: const Color.fromARGB(255, 247, 247, 247),
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 220, 104, 145),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48.0),
              child: Container(
                color: const Color.fromARGB(255, 220, 104, 145),
                child: const TabBar(
                  tabs: [
                    Tab(text: "Upcoming"),
                    Tab(text: "Completed"),
                  ],
                  indicatorColor: Colors.white,
                ),
              ),
            ),
            title: const Text('Vaccination Tracker'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                // Handle back button press here
                Navigator.of(context).pop();
              },
            ),
          ),
          body: TabBarView(
            children: [
              buildVaccinationTabUpcoming(), // Upcoming vaccinations
              buildVaccinationTabCompleted(), // Completed vaccinations
            ],
          ),
        ),
      ),
    );
  }

  Widget buildVaccinationTabUpcoming() {
    return ValueListenableBuilder<int>(
      valueListenable: refreshCounter,
      builder: (context, _, __) {
        return FutureBuilder<List<Vaccination>>(
          future: upcomingVaccinations,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No upcoming vaccinations'),
              );
            } else {
              List<Vaccination> vaccinations = snapshot.data!;
              return Column(
                children: [
                  const SizedBox(height: 25.0),
                  for (var vaccination in vaccinations)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        tileColor: const Color.fromARGB(255, 255, 255, 255),
                        leading: const Icon(Icons.calendar_today,
                            color: Color.fromARGB(255, 220, 104, 145)),
                        title: Text(vaccination.name ?? ''),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              calculateVaccinationDate(
                                  vaccination.daysFromBirth),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              calculateRemainingDays(
                                vaccination.daysFromBirth,
                              ),
                              style: TextStyle(
                                color: determineTextColor(
                                    vaccination.daysFromBirth),
                              ),
                            ),
                          ],
                        ),
                        trailing: TextButton(
                          onPressed: () async {
                            final value = await babyId;
                            try {
                              await VaccinationService
                                  .markCompletedBabyVaccination(
                                      value, vaccination.id);
                              _refreshData();
                            } catch (error) {
                              print(
                                  'Error marking vaccination as completed: $error');
                            }
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 220, 104, 145),
                          ),
                          child: const Text('Completed'),
                        ),
                      ),
                    ),
                  ElevatedButton(
                    onPressed: () {
                      NotificationService.showBigTextNotifications(
                          title: "Message title",
                          body: "message body",
                          fln: flutterLocalNotificationsPlugin);
                    }, // saveData function
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 220, 104, 145),
                    ),
                    child: const Text('Save Data'),
                  )
                ],
              );
            }
          },
        );
      },
    );
  }

  Widget buildVaccinationTabCompleted() {
    return ValueListenableBuilder<int>(
      valueListenable: refreshCounter,
      builder: (context, _, __) {
        return FutureBuilder<List<Vaccination>>(
          future: completedVaccinations,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No Completed vaccinations'),
              );
            } else {
              List<Vaccination> vaccinations = snapshot.data!;
              return Column(
                children: [
                  const SizedBox(height: 25.0),
                  for (var vaccination in vaccinations)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        tileColor: const Color.fromARGB(255, 255, 255, 255),
                        leading: const Icon(Icons.calendar_today,
                            color: Color.fromARGB(255, 220, 104, 145)),
                        title: Text(vaccination.name ?? ''),
                        subtitle: Text(vaccination.description ?? ''),
                        trailing: const Icon(
                          Icons.done,
                          color: Color.fromARGB(255, 220, 104, 145),
                        ),
                      ),
                    ),
                ],
              );
            }
          },
        );
      },
    );
  }
}

String calculateVaccinationDate(int? daysFromBirth) {
  if (daysFromBirth == null) {
    return 'Due Date: N/A';
  }

  final currentDate = DateTime.now();
  final vaccinationDate = currentDate.add(Duration(days: daysFromBirth));

  final day = vaccinationDate.day.toString().padLeft(2, '0');
  final month = vaccinationDate.month.toString().padLeft(2, '0');
  final year = vaccinationDate.year.toString();

  final formattedDate = '$day/$month/$year';
  return 'Due Date: $formattedDate';
}

String calculateRemainingDays(int? daysFromBirth) {
  if (daysFromBirth == null) {
    return 'N/A';
  }

  final difference = daysFromBirth;

  if (difference == 0) {
    return 'Today';
  } else if (difference == 1) {
    return 'Tomorrow';
  } else if (difference < 0) {
    return 'Overdue';
  } else if (difference > 30) {
    final months = difference ~/ 30;
    final remainingDays = difference % 30;
    if (months == 1) {
      if (remainingDays == 0) {
        return '1 month left';
      } else if (remainingDays == 1) {
        return '1 month and 1 day left';
      } else {
        return '1 month and $remainingDays days left';
      }
    } else {
      if (remainingDays == 0) {
        return '$months months left';
      } else if (remainingDays == 1) {
        return '$months months and 1 day left';
      } else {
        return '$months months and $remainingDays days left';
      }
    }
  } else {
    return '$difference days left';
  }
}

Color determineTextColor(int? daysFromBirth) {
  if (daysFromBirth == null) {
    return Colors.black;
  }

  if (daysFromBirth < 0) {
    return Colors.red;
  }

  return Colors.green;
}
