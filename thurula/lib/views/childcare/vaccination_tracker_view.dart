import 'package:flutter/material.dart';
import 'package:thurula/services/local_service.dart';
import 'package:thurula/services/vaccination_service.dart';
import 'package:thurula/models/vaccination_model.dart';

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

  @override
  void initState() {
    super.initState();
    babyId = LocalService.getCurrentBabyId();
    refreshCounter = ValueNotifier<int>(0); // Initialize the ValueNotifier
    _refreshData();
  }

  Future<void> _refreshData() async {
    final babyIdValue = await babyId;
    upcomingVaccinations = VaccinationService.getDueVaccinations(babyIdValue);
    completedVaccinations =
        VaccinationService.getCompletedVaccinations(babyIdValue);
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
                        subtitle: Text(vaccination.description ?? ''),
                        trailing: TextButton(
                          onPressed: () async {
                            final value = await babyId;
                            try {
                              await VaccinationService.markCompletedVaccination(
                                  value, vaccination.id);
                              _refreshData(); // Update the data and UI
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
