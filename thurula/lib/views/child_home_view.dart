import 'package:flutter/material.dart';
import 'package:thurula/views/childcare/exercise/ExerciseView.dart';
import 'package:thurula/views/childcare/vision/VisionMenuView.dart';
import 'package:thurula/views/diaper_change.dart';
import 'package:thurula/views/nap_details.dart';
import 'package:thurula/views/child_vaccination_tracker_view.dart';
import 'package:thurula/views/length_chart_view.dart';
import 'package:thurula/views/login_view.dart';
import 'package:thurula/views/meal_tracker.dart';

class ChildHomeView extends StatelessWidget {
  const ChildHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      body: Stack(
        children: [
          const Positioned(
            top: 20,
            left: 25,
            child: Text(
              "Welcome Ama!",
              style: TextStyle(
                color: Color.fromARGB(255, 88, 119, 161),
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 35,
            left: 15,
            right: 20,
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
                            color: Colors.white,
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
                                    'assets/images/menu-icons/growth.png',
                                    height: 60),
                              ),
                              const SizedBox(height: 10),
                              const Text("Growth Tracker",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
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
                            color: Colors.white,
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
                                    'assets/images/menu-icons/vaccine.png',
                                    height: 60),
                              ),
                              const SizedBox(height: 10),
                              const Text("Vaccination Tracker",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
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
                            color: Colors.white,
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
                                    'assets/images/menu-icons/nap.png',
                                    height: 60),
                              ),
                              const SizedBox(height: 10),
                              const Text("Nap Time Monitoring",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
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
                            color: Colors.white,
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
                                    'assets/images/menu-icons/diaper.png',
                                    height: 50),
                              ),
                              const SizedBox(height: 10),
                              const Text("Diaper Change\nMonitoring",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
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
                              builder: (context) => MealTracker(),
                            ),
                          );
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
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
                                    'assets/images/menu-icons/feeding.png',
                                    height: 60),
                              ),
                              const SizedBox(height: 10),
                              const Text("Feeding Monitoring",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
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
                              builder: (context) => ExerciseView(),
                            ),
                          );
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
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
                                    'assets/images/menu-icons/skills.png',
                                    height: 55),
                              ),
                              const SizedBox(height: 10),
                              const Text("Skill Development\nExercises",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
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
                              builder: (context) => const VisionMenuView(),
                            ),
                          );
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
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
                                    'assets/images/menu-icons/vision.png',
                                    height: 55),
                              ),
                              const SizedBox(height: 10),
                              const Text("Vision Test",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
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
              top: 190,
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
                      blurRadius: 2,
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
                          padding: const EdgeInsets.all(
                              10.0), // change this to the desired amount of padding
                          child: ClipRRect(
                            child: Image.asset(
                                'assets/images/child-home/countdown.png',
                                height: 150),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            'Your baby is 100 days old!',
                            style: TextStyle(
                              color: Color.fromARGB(255, 88, 119, 161),
                              fontSize: 16.0,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ],

                    )
                  ),
                ),
              )
          ),
          Positioned(
              top: 410,
              left: 20,
              right: 20,
              child: Container(
                width: 400,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Your baby is 10kg and 70cm \ntall!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 88, 119, 161),
                        ),
                      ),
                      const Padding(
                          //   padding on left and right
                          padding: EdgeInsets.only(
                        left: 5.0,
                        right: 10.0,
                      )),
                      Image.asset(
                        'assets/images/child-home/size.png',
                        height: 60,
                      ),
                    ],
                  ),
                ),
              )),
          Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: Container(
                width: 400,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                            left: 22.0,
                          ),
                            child: Text(
                              'Baby\'s next vaccine is in',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 220, 104, 145),
                                  fontSize: 17.0,
                                  height: 1.5,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold),
                            ),
                      )),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 0.0,
                        ),
                        child: ClipRRect(
                          child: Image.asset(
                              'assets/images/child-home/calendar/30.png',
                              height: 60),
                        ),
                      ),
                      const Padding(
                        // padding right
                        padding: EdgeInsets.only(
                          right: 22.0,
                          left: 10.0,
                        ),
                        child: Text(
                          'days',
                          style: TextStyle(
                              color: Color.fromARGB(255, 220, 104, 145),
                              fontSize: 17.0,
                              height: 1.5,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold),
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
