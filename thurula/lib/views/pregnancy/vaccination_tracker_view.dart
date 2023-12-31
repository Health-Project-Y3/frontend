import 'package:flutter/material.dart';
import 'package:thurula/services/local_service.dart';
import 'package:thurula/services/vaccination_service.dart';
import 'package:thurula/models/vaccination_model.dart';
import 'package:thurula/views/custom_loading_indicator.dart';

import '../widgets/navbar_widget.dart';

class MomVaccinationTrackerView extends StatefulWidget {
  const MomVaccinationTrackerView({super.key});

  @override
  _VaccinationTrackerViewState createState() => _VaccinationTrackerViewState();
}

class _VaccinationTrackerViewState extends State<MomVaccinationTrackerView> {
  late ValueNotifier<int> refreshCounter;
  late Future<List<Vaccination>> upcomingVaccinations;
  late Future<List<Vaccination>> completedVaccinations;
  late Future<String> UserId;

  @override
  void initState() {
    super.initState();
    UserId = LocalService.getCurrentUserId();
    refreshCounter = ValueNotifier<int>(0); // Initialize the ValueNotifier
    _refreshData();
  }

  Future<void> _refreshData() async {
    final UserIdValue = await UserId;
    upcomingVaccinations =
        VaccinationService.getDueMomVaccinations(UserIdValue);
    completedVaccinations =
        VaccinationService.getCompletedMomVaccinations(UserIdValue);
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
          bottomNavigationBar: const CreateBottomNavigationBar(pageIndex: 1),
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
              return CustomLoadingIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No upcoming vaccinations'),
              );
            } else {
              List<Vaccination> vaccinations = snapshot.data!;
              return SingleChildScrollView(
                  child: Column(
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
                            final value = await UserId;
                            try {
                              await VaccinationService
                                  .markCompletedMomVaccination(
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
                ],
              ));
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
              return CustomLoadingIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No Completed vaccinations'),
              );
            } else {
              List<Vaccination> vaccinations = snapshot.data!;
              return SingleChildScrollView(
                  child: Column(
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
                        trailing: TextButton(
                          onPressed: () async {
                            final value = await UserId;
                            try {
                              await VaccinationService
                                  .undoCompletedMomVaccination(
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
                          child: const Text('Undo'),
                        ),
                      ),
                    ),
                ],
              ));
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
