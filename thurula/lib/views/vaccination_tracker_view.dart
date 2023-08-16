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
  late Future<List<Vaccination>> upcomingVaccinations;
  late Future<List<Vaccination>> completedVaccinations;
  late Future<String> babyId;

  @override
  void initState() {
    super.initState();
    babyId = LocalService.getCurrentBabyId();
    babyId.then((value) {
      upcomingVaccinations = VaccinationService.getDueVaccinations(value);
      completedVaccinations =
          VaccinationService.getCompletedVaccinations(value);
      setState(() {
        upcomingVaccinations = upcomingVaccinations;
        completedVaccinations = completedVaccinations;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 227, 227, 227),
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48.0),
              child: Container(
                color: const Color.fromARGB(255, 220, 104, 145),
                child: const TabBar(
                  tabs: [
                    Tab(text: "Upcoming"),
                    Tab(text: "Completed"),
                  ],
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
              buildVaccinationTabUpcoming(
                  upcomingVaccinations), // Upcoming vaccinations
              buildVaccinationTabCompleted(
                  completedVaccinations), // Completed vaccinations
            ],
          ),
        ),
      ),
    );
  }

  buildVaccinationTabUpcoming(Future<List<Vaccination>> upcomingVaccinations) {
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
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Upcoming Vaccination Appointments",
                    style: TextStyle(
                      color: Color.fromARGB(255, 88, 119, 161),
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              for (var vaccination in vaccinations)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    tileColor: const Color.fromARGB(255, 255, 255, 255),
                    leading: const Icon(Icons.calendar_today,
                        color: Color.fromARGB(255, 220, 104, 145)),
                    title: Text(vaccination.name ?? ''),
                    subtitle: Text(vaccination.description ?? ''),
                    trailing: TextButton(
                      onPressed: () {
                        babyId.then((value) {
                          VaccinationService.markCompletedVaccination(
                              value, vaccination.id);
                          setState(() {
                            // Refresh the UI to reflect the changes
                            completedVaccinations =
                                VaccinationService.getCompletedVaccinations(
                                    value);
                          });
                        });
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
  }

  buildVaccinationTabCompleted(
      Future<List<Vaccination>> completedVaccinations) {
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
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Completed Vaccination Appointments",
                    style: TextStyle(
                      color: Color.fromARGB(255, 88, 119, 161),
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              for (var vaccination in vaccinations)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    tileColor: const Color.fromARGB(255, 255, 255, 255),
                    leading: const Icon(
                      Icons.calendar_today,
                      color: Color.fromARGB(255, 220, 104, 145),
                    ),
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
  }
}
