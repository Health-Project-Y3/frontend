import 'package:flutter/material.dart';
import 'package:thurula/views/diaper_change.dart';
import 'package:thurula/views/nap_details.dart';
import 'package:thurula/views/child_vaccination_tracker_view.dart';
import 'package:thurula/views/length_chart_view.dart';
import 'package:thurula/views/login_view.dart';

class ChildHomeView extends StatelessWidget {
  const ChildHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          const Positioned(
            top: 50,
            left: 20,
            child: Text(
              "Welcome Nadeeka!",
              style: TextStyle(
                color: Color.fromARGB(255, 220, 104, 145),
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 70,
            left: 5,
            right: 5,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              height: 120,
              width: MediaQuery.of(context).size.width, // Set the width
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  //Growth Tracker
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkResponse(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LengthChartView(),
                            ),
                          );
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(223, 247, 198, 193),
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                child: Image.asset(
                                    'assets/images/menu-icons/growth.png',
                                    height: 60),
                              ),
                              const SizedBox(height: 10),
                              const Text("Growth Tracker",
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 88, 119, 161),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      )),
//Vaccination Tracker
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkResponse(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ChildVaccinationTrackerView(),
                            ),
                          );
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(223, 247, 198, 193),
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                child: Image.asset(
                                    'assets/images/menu-icons/vaccine.png',
                                    height: 60),
                              ),
                              const SizedBox(height: 10),
                              const Text("Vaccination Tracker",
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 88, 119, 161),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      )),
//Nap Time Monitoring
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkResponse(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NapDetails(),
                            ),
                          );
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(223, 247, 198, 193),
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                child: Image.asset(
                                    'assets/images/menu-icons/nap.png',
                                    height: 60),
                              ),
                              const SizedBox(height: 10),
                              const Text("Nap Time Monitoring",
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 88, 119, 161),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      )),
//Diaper Change Monitoring
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkResponse(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DiaperChange(),
                            ),
                          );
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(223, 247, 198, 193),
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                child: Image.asset(
                                    'assets/images/menu-icons/diaper.png',
                                    height: 50),
                              ),
                              const SizedBox(height: 10),
                              const Text("Diaper Change\nMonitoring",
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 88, 119, 161),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      )),
                  //Feeding Monitoring
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkResponse(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChildHomeView(),
                            ),
                          );
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(223, 247, 198, 193),
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                child: Image.asset(
                                    'assets/images/menu-icons/feeding.png',
                                    height: 60),
                              ),
                              const SizedBox(height: 10),
                              const Text("Feeding Monitoring",
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 88, 119, 161),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      )),

                  //Skill Development Exercises
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkResponse(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChildHomeView(),
                            ),
                          );
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(223, 247, 198, 193),
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                child: Image.asset(
                                    'assets/images/menu-icons/skills.png',
                                    height: 55),
                              ),
                              const SizedBox(height: 10),
                              const Text("Skill Development\nExercises",
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 88, 119, 161),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
          Positioned(
              top: 230,
              left: 20,
              child: Container(
                width: 400,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(
                            10.0), // change this to the desired amount of padding
                        child: ClipRRect(
                          child: Image.asset(
                              'assets/images/child-home/countdown.png',
                              height: 150),
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          'Your Baby is 100 days Old!',
                          style: TextStyle(
                            color: Color.fromARGB(255, 88, 119, 161),
                            fontSize: 16.0,
                            height: 1.5,
                            fontFamily: 'Inter',
                          ), // change this to the desired text color
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          Positioned(
              top: 450,
              left: 20,
              child: Container(
                width: 400,
                height: 150,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 249, 201, 201),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Row(
                    children: [
                      const Expanded(
                          child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Your baby is 10kg and 70cm tall!',
                          style: TextStyle(
                              color: Color.fromARGB(255, 88, 119, 161),
                              fontSize: 18.0,
                              height: 1.5,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight
                                  .bold), // change this to the desired text color
                        ),
                      )),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 5.0,
                          right: 10.0,
                        ), // change this to the desired amount of padding
                        child: ClipRRect(
                          child: Image.asset(
                              'assets/images/child-home/size.png',
                              height: 80),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          Positioned(
              top: 630,
              left: 40,
              right: 40,
              child: Container(
                width: 400,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 88, 119, 161),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Row(
                    children: [
                      const Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(
                          left: 15.0,
                        ),
                        child: Text(
                          'Baby\'s next vaccine is in',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 20.0,
                              height: 1.5,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight
                                  .bold), // change this to the desired text color
                        ),
                      )),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 5.0,
                        ), // change this to the desired amount of padding
                        child: ClipRRect(
                          child: Image.asset(
                              'assets/images/child-home/calendar/30.png',
                              height: 60),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(
                            10.0), // change this to the desired amount of padding
                        child: Text(
                          'Days',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 20.0,
                              height: 1.5,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight
                                  .bold), // change this to the desired text color
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          Positioned(
            top: 30,
            right: 10,
            child: Material(
              color: Colors.transparent,
              child: Ink(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginView(),
                      ),
                    );
                  },
                  iconSize: 30,
                  icon: const Icon(
                    Icons.logout_rounded,
                    color: Color.fromARGB(255, 220, 104, 145),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
