import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thurula/views/HomeView.dart';
import 'package:thurula/views/childcare/growth_chart_view.dart';
import 'package:thurula/views/childcare/vaccination_tracker_view.dart';
import 'package:thurula/views/childcare/vision/VisionMenuView.dart';
import 'package:thurula/views/childcare/exercise/ExerciseView.dart';

// import 'package:provider/provider.dart';

class ChildCareMenuView extends StatelessWidget {
  const ChildCareMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    // final model = Provider.of<HomeModel>(context);

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 227, 227, 227),
        body: GridView.count(crossAxisCount: 3, children: [
          //Growth Tracker
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: InkResponse(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GrowthChartView(),
                    ),
                  );
                },
                child: Container(
                  width: 200,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: Image.asset(
                            'assets/images/menu-icons/growth.png',
                            height: 60),
                      ),
                      const SizedBox(height: 20),
                      const Text("Growth Tracker",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color.fromARGB(255, 220, 104, 145),
                              fontSize: 13,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              )),
//Vaccination Tracker
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: InkResponse(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VaccinationTrackerView(),
                    ),
                  );
                },
                child: Container(
                  width: 200,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: Image.asset(
                            'assets/images/menu-icons/vaccine.png',
                            height: 60),
                      ),
                      const SizedBox(height: 20),
                      const Text("Vaccination\nTracker",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color.fromARGB(255, 220, 104, 145),
                              fontSize: 13,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              )),
//Feeding Monitoring
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: InkResponse(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeView(),
                    ),
                  );
                },
                child: Container(
                  width: 200,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: Image.asset(
                            'assets/images/menu-icons/feeding.png',
                            height: 60),
                      ),
                      const SizedBox(height: 20),
                      const Text("Feeding\nMonitoring",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color.fromARGB(255, 220, 104, 145),
                              fontSize: 13,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              )),
//Nap Time Monitoring
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: InkResponse(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeView(),
                    ),
                  );
                },
                child: Container(
                  width: 200,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: Image.asset('assets/images/menu-icons/nap.png',
                            height: 60),
                      ),
                      const SizedBox(height: 20),
                      const Text("Nap Time\nMonitoring",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color.fromARGB(255, 220, 104, 145),
                              fontSize: 13,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              )),
//Diaper Change Monitoring
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: InkResponse(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeView(),
                    ),
                  );
                },
                child: Container(
                  width: 200,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: Image.asset(
                            'assets/images/menu-icons/diaper.png',
                            height: 60),
                      ),
                      const SizedBox(height: 20),
                      const Text("Diaper Change\nMonitoring",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color.fromARGB(255, 220, 104, 145),
                              fontSize: 13,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              )),
//Photo Album
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: InkResponse(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeView(),
                    ),
                  );
                },
                child: Container(
                  width: 200,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: Image.asset('assets/images/menu-icons/album.png',
                            height: 60),
                      ),
                      const SizedBox(height: 20),
                      const Text("Photo Album",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color.fromARGB(255, 220, 104, 145),
                              fontSize: 13,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              )),
//Vision Test
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                  width: 200,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: Image.asset(
                            'assets/images/menu-icons/vision.png',
                            height: 60),
                      ),
                      const SizedBox(height: 20),
                      const Text("Vision Test",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color.fromARGB(255, 220, 104, 145),
                              fontSize: 13,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              )),
          //Skill Development Exercises
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                  width: 200,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: Image.asset(
                            'assets/images/menu-icons/skills.png',
                            height: 60),
                      ),
                      const SizedBox(height: 20),
                      const Text("Checklist",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color.fromARGB(255, 220, 104, 145),
                              fontSize: 13,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              )),
          //Food Recommendations
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: InkResponse(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeView(),
                    ),
                  );
                },
                child: Container(
                  width: 200,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: Image.asset('assets/images/menu-icons/food2.png',
                            height: 60),
                      ),
                      const SizedBox(height: 20),
                      const Text("Food\nRecommendations",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color.fromARGB(255, 220, 104, 145),
                              fontSize: 13,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              )),
          //Forum
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: InkResponse(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeView(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: Image.asset('assets/images/menu-icons/forum.png',
                            height: 60),
                      ),
                      const SizedBox(height: 20),
                      const Text('Forum',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color.fromARGB(255, 220, 104, 145),
                              fontSize: 13,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              )),
          // Product Recommendations
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: InkResponse(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeView(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: Image.asset(
                            'assets/images/menu-icons/products2.png',
                            height: 60),
                      ),
                      const SizedBox(height: 20),
                      const Text('Product\nRecommendations',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color.fromARGB(255, 220, 104, 145),
                              fontSize: 13,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              )),
          //Article Recommendations
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: InkResponse(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeView(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: Image.asset(
                            'assets/images/menu-icons/article2.png',
                            height: 60),
                      ),
                      const SizedBox(height: 20),
                      const Text('Article\nRecommendations',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color.fromARGB(255, 220, 104, 145),
                              fontSize: 13,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              )),
        ]));
  }
}
