import 'package:flutter/material.dart';
import 'package:thurula/views/login_view.dart';
import 'package:thurula/views/mother_health_tracker.dart';
import 'package:thurula/views/pregnancy_timeline_view.dart';
import 'package:thurula/views/pregnancy_vaccination_tracker_view.dart';
import 'package:thurula/views/pregnancy_exercise_recommendations_view.dart';
import 'package:thurula/views/pregnancy_baby_names_view.dart';

class PregnancyHomeView extends StatelessWidget {
  const PregnancyHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          const Positioned(
            top: 20,
            left: 20,
            child: Text(
              "Welcome Ama!",
              style: TextStyle(
                color: Color.fromARGB(255, 220, 104, 145),
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 20,
            right: 20,
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
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.5,
                                blurRadius: 2,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                child: Image.asset(
                                    'assets/images/menu-tiles/timeline2.png',
                                    height: 100),
                              ),
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
                              builder: (context) => MotherHealthTracker(),
                            ),
                          );
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.5,
                                blurRadius: 2,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                child: Image.asset(
                                    'assets/images/menu-tiles/monitor2.png',
                                    height: 100),
                              ),
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
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.5,
                                blurRadius: 3,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                child: Image.asset(
                                    'assets/images/menu-tiles/vaccine2.png',
                                    height: 100),
                              ),
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
                              builder: (context) => const ExercisesView(),
                            ),
                          );
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.5,
                                blurRadius: 3,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                child: Image.asset(
                                    'assets/images/menu-tiles/exercise2.png',
                                    height: 100),
                              ),
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
                              builder: (context) => const BabyNames(),
                            ),
                          );
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.5,
                                blurRadius: 3,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                child: Image.asset(
                                    'assets/images/menu-tiles/names2.png',
                                    height: 100),
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),

          // days left
          Positioned(
            top: 205,
            left: 20,
            right: 20,
            child: Container(
              width: 400,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0.5,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Column(
                    children: [
                      Padding(
                        // padding top
                        padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                        child: ClipRRect(
                          child: Image.asset(
                            'assets/images/pregnancy-home/countdown1.jpg',
                            height: 150,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          '70 days left for your bundle of joy to arrive!',
                          style: TextStyle(
                            color: Color.fromARGB(255, 88, 119, 161),
                            fontSize: 16.0,
                            fontFamily: 'Inter',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

          // baby size
          Positioned(
            top: 415,
            left: 20,
            right: 20,
            child: IntrinsicHeight(
              child: Container(
                width: 400,
                // height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0.5,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          // bullet point
                          Icon(
                            Icons.square,
                            size: 10,
                            color: Color.fromARGB(255, 88, 119, 161),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Week 25 Day 6',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 88, 119, 161),
                            ),
                          ),
                          Spacer(), // Spacer to push the length and weight to the right
                          Text(
                            '34.6 cm 660.0 g',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 88, 119, 161),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Your baby is putting on fat and growing chubbier, which helps the baby adapt to the relatively low temperature of the outside world after leaving the womb.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            'Your baby is as big as a \nstrawberry',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 88, 119, 161),
                            ),
                          ),
                          Image.asset(
                            'assets/images/pregnancy-home/strawberry2.png',
                            height: 80,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Positioned(
              bottom: 40,
              left: 20,
              right: 20,
              child: Container(
                width: 380,
                height: 80,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0.5,
                      blurRadius: 2,
                      offset: const Offset(0, 2),
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
                              color: Color.fromARGB(255, 88, 119, 161),
                              fontSize: 20.0,
                              height: 1.5,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 5.0,
                        ),
                        child: ClipRRect(
                          child: Image.asset(
                              'assets/images/pregnancy-home/calendar/9.png',
                              height: 60),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'days',
                          style: TextStyle(
                              color: Color.fromARGB(255, 88, 119, 161),
                              fontSize: 20.0,
                              height: 1.5,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          Positioned(
            top: 10,
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