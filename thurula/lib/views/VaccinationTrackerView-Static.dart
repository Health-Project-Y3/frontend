import 'package:flutter/material.dart';
import 'package:thurula/views/menu_view.dart';

class VaccinationTrackerView2 extends StatelessWidget {
  const VaccinationTrackerView2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 227, 227, 227),
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48.0), // height of  TabBar
              child: Container(
                color: const Color.fromARGB(255, 220, 104, 145),
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
            title: const Text('Vaccination Tracker'),
            actions: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MenuView()));
                      })),
            ],
          ),
          body: TabBarView(
            children: [
              Column(
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      tileColor: const Color.fromARGB(255, 255, 255, 255),
                      leading: const Icon(Icons.calendar_today,
                          color: Color.fromARGB(255, 220, 104, 145)),
                      title: const Text('BCG Vaccine'),
                      subtitle: const Text('Saturday, 19th August 2023'),
                      trailing: TextButton(
                        onPressed: () {
                          // Handle Completed button press
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          backgroundColor:
                              const Color.fromARGB(255, 220, 104, 145),
                        ),
                        child: const Text('Completed'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      tileColor: const Color.fromARGB(255, 255, 255, 255),
                      leading: const Icon(Icons.calendar_today,
                          color: Color.fromARGB(255, 220, 104, 145)),
                      title: const Text('Polio Vaccine'),
                      subtitle: const Text('Thursday, 31st August 2023'),
                      trailing: TextButton(
                        onPressed: () {
                          // Handle Completed button press
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          backgroundColor:
                              const Color.fromARGB(255, 220, 104, 145),
                        ),
                        child: const Text('Completed'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      tileColor: const Color.fromARGB(255, 255, 255, 255),
                      leading: const Icon(Icons.calendar_today,
                          color: Color.fromARGB(255, 220, 104, 145)),
                      title: const Text('DTaP Vaccine'),
                      subtitle: const Text('Wednesday, 20th September 2023'),
                      trailing: TextButton(
                        onPressed: () {
                          // Handle Completed button press
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          backgroundColor:
                              const Color.fromARGB(255, 220, 104, 145),
                        ),
                        child: const Text('Completed'),
                      ),
                    ),
                  )
                ],
              ),
              Column(
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      tileColor: const Color.fromARGB(255, 255, 255, 255),
                      leading: const Icon(Icons.calendar_today,
                          color: Color.fromARGB(255, 220, 104, 145)),
                      title: const Text('Hepatitis B  - 1st Dose'),
                      subtitle: const Text('Wednesday, 10th May 2023'),
                      trailing: const Icon(Icons.done,
                          color: Color.fromARGB(255, 220, 104, 145)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      tileColor: const Color.fromARGB(255, 255, 255, 255),
                      leading: const Icon(Icons.calendar_today,
                          color: Color.fromARGB(255, 220, 104, 145)),
                      title: const Text('Hepatitis B  - 2nd Dose'),
                      subtitle: const Text('Monday, 12th July 2023'),
                      trailing: const Icon(Icons.done,
                          color: Color.fromARGB(255, 220, 104, 145)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
