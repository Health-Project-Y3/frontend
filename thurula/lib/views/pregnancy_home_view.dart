import 'package:flutter/material.dart';
import 'package:thurula/views/pregnancy_menu_view.dart';
import 'package:thurula/views/pregnancy_timeline_view.dart';
import 'package:thurula/views/pregnancy_vaccination_tracker_view.dart';

class PregnancyHomeView extends StatelessWidget {
  const PregnancyHomeView({super.key});

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
              "Welcome Emily!",
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
                  //Pregnancy Timeline
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkResponse(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PregnancyTimelineView(),
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
                                    'assets/images/menu-icons/timeline.png',
                                    height: 60),
                              ),
                              const SizedBox(height: 10),
                              const Text('Pregancny\nTimeline',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 88, 119, 161),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      )),
                  //Health Monitoring
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkResponse(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PregnancyHomeView(),
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
                                    'assets/images/menu-icons/healthcare.png',
                                    height: 60),
                              ),
                              const SizedBox(height: 10),
                              const Text('Health\nMonitoring',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 88, 119, 161),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      )),
                  //Exercise Recommendations
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkResponse(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PregnancyHomeView(),
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
                                    'assets/images/menu-icons/exercises.png',
                                    height: 60),
                              ),
                              const SizedBox(height: 10),
                              const Text('Exercise\nRecommendations',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 88, 119, 161),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      )),
                  //Baby Name Suggestions
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkResponse(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PregnancyHomeView(),
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
                                    'assets/images/menu-icons/names.png',
                                    height: 60),
                              ),
                              const SizedBox(height: 10),
                              const Text('Baby Name\nSuggestions',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color.fromARGB(255, 88, 119, 161),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      )),
                  //Vaccination Tracking
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkResponse(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PregnancyVaccinationTrackerView(),
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
                              const Text('Vaccination Tracking',
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
                              'assets/images/pregnancy-home/countdown.png',
                              height: 120),
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          '70 days left for your bundle of joy to arrive!',
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
                  color: const Color.fromARGB(255, 231, 159, 159),
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
                          'Your baby is as big as a Strawberry',
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
                              'assets/images/pregnancy-home/size.png',
                              height: 80),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          Positioned(
              top: 630,
              left: 50,
              right: 50,
              child: Container(
                width: 380,
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
                          'Your next vaccine is in',
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
                              'assets/images/pregnancy-home/calendar/9.png',
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
        ],
      ),
    );
  }
}
