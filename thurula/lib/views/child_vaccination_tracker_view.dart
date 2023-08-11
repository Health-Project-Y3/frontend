import 'package:flutter/material.dart';

class VaccinationDetails {
  final String vaccineName;
  final String date;
  bool completed;

  VaccinationDetails(this.vaccineName, this.date, this.completed);
}

class ChildVaccinationTrackerView extends StatefulWidget {
  ChildVaccinationTrackerView({super.key});

  @override
  _PregnancyVaccinationTrackerViewState createState() =>
      _PregnancyVaccinationTrackerViewState();
}

class _PregnancyVaccinationTrackerViewState
    extends State<ChildVaccinationTrackerView> {
  List<VaccinationDetails> upcomingVaccinations = [
    VaccinationDetails('Hib Vaccine', 'Saturday, 19th August 2023', false),
    VaccinationDetails(
        'TPolio Vaccine (IPV)', 'Thursday, 31st August 2023', false),
    VaccinationDetails('PCV Vaccine', 'Tuesday, 12th September 2023', false),
    VaccinationDetails('RV Vaccine (Rotavirus Vaccine)',
        'Wednesday, 20th September 2023', false),
    VaccinationDetails(
        'Influenza Vaccine (Flu Vaccine)', 'Monday, 9 October 2023', false),
    VaccinationDetails('MMR Vaccine', 'Monday, 9 October 2023', false),
    VaccinationDetails(
        'Varicella (Chickenpox) Vaccine', 'Monday, 9 October 2023', false),
    VaccinationDetails('Hepatitis A Vaccine', 'Monday, 9 October 2023', false),
  ];

  List<VaccinationDetails> completedVaccinations = [
    VaccinationDetails('Hepatitis B Vaccine', 'Wednesday, 10th May 2023', true),
    VaccinationDetails('DTaP Vaccine', 'Monday, 12th July 2023', true),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 244, 200, 200),
          appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 244, 200, 200),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
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
                        text: "Upcoming",
                      ),
                      Tab(
                        text: "Completed",
                      ),
                    ],
                  ),
                ),
              ),
              title: const Text(
                'Vaccination Tracker',
                style: TextStyle(
                  color: Color.fromARGB(255, 88, 119, 161),
                ),
              )),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                  child: Column(
                children: [
                  const Center(
                      child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text("Upcoming Vaccination Appointments",
                        style: TextStyle(
                          color: Color.fromARGB(255, 88, 119, 161),
                          fontFamily: 'Montserrat',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  )),
                  for (var vaccine in upcomingVaccinations)
                    _buildVaccinationTile(vaccine),
                ],
              )),
              SingleChildScrollView(
                  child: Column(
                children: [
                  const Center(
                      child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text("Completed Vaccination Appointments",
                        style: TextStyle(
                          color: Color.fromARGB(255, 88, 119, 161),
                          fontFamily: 'Montserrat',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  )),
                  for (var vaccine in completedVaccinations)
                    _buildCompletedVaccinationTile(vaccine),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVaccinationTile(VaccinationDetails vaccine) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        tileColor: const Color.fromARGB(255, 255, 255, 255),
        leading: const Icon(Icons.calendar_today,
            color: Color.fromARGB(255, 220, 104, 145)),
        title: Text(vaccine.vaccineName),
        subtitle: Text(vaccine.date),
        trailing: TextButton(
          onPressed: () {
            setState(() {
              vaccine.completed = true;
              upcomingVaccinations.remove(vaccine);
              completedVaccinations.add(vaccine);
            });
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            backgroundColor: const Color.fromARGB(255, 220, 104, 145),
          ),
          child: const Text('Completed'),
        ),
      ),
    );
  }

  Widget _buildCompletedVaccinationTile(VaccinationDetails vaccine) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        tileColor: const Color.fromARGB(255, 255, 255, 255),
        leading: const Icon(Icons.calendar_today,
            color: Color.fromARGB(255, 220, 104, 145)),
        title: Text(vaccine.vaccineName),
        subtitle: Text(vaccine.date),
        trailing:
            const Icon(Icons.done, color: Color.fromARGB(255, 220, 104, 145)),
      ),
    );
  }
}
