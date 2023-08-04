import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:thurula/views/widgets/wave_widget.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:thurula/views/MenuView.dart';
import 'package:thurula/views/PregnancyTimelineView.dart';
import 'package:thurula/views/VaccinationTrackerView.dart';
import 'package:thurula/views/length_chart_view.dart';

import 'HomeView.dart';
import 'Question2View.dart';
// import 'package:provider/provider.dart';

class ChildCareMenuView extends StatelessWidget {
  const ChildCareMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    // final model = Provider.of<HomeModel>(context);

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 227, 227, 227),
        body: GridView.count(crossAxisCount: 3, children: [
          Column(
            children: [
              IconButton(
                  icon: const Icon(Icons.person,
                      size: 60, color: Color.fromARGB(255, 220, 104, 145)),
                  // label: const Text("Baby Tracker"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LengthChartView()));
                  }),
              const Padding(
                padding: EdgeInsets.fromLTRB(17, 10, 0, 0),
                child: Text(
                  "Growth Tracker",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                  icon: const Icon(Icons.person,
                      size: 60, color: Color.fromARGB(255, 220, 104, 145)),
                  // label: const Text("Baby Tracker"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const VaccinationTrackerView()));
                  }),
              const Padding(
                padding: EdgeInsets.fromLTRB(12, 10, 0, 0),
                child: Text(
                  "Vaccination Tracker",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                  icon: const Icon(Icons.person,
                      size: 60, color: Color.fromARGB(255, 220, 104, 145)),
                  // label: const Text("Baby Tracker"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MenuView()));
                  }),
              const Padding(
                padding: EdgeInsets.fromLTRB(12, 10, 0, 0),
                child: Text(
                  "Feeding Monitoring",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                  icon: const Icon(Icons.person,
                      size: 60, color: Color.fromARGB(255, 220, 104, 145)),
                  // label: const Text("Baby Tracker"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MenuView()));
                  }),
              const Padding(
                padding: EdgeInsets.fromLTRB(12, 10, 0, 0),
                child: Text(
                  "Nap Time Monitoring",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                  icon: const Icon(Icons.person,
                      size: 60, color: Color.fromARGB(255, 220, 104, 145)),
                  // label: const Text("Baby Tracker"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MenuView()));
                  }),
              const Padding(
                padding: EdgeInsets.fromLTRB(12, 10, 0, 0),
                child: Text(
                  "Diaper Change Monitoring",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                  icon: const Icon(Icons.person,
                      size: 60, color: Color.fromARGB(255, 220, 104, 145)),
                  // label: const Text("Baby Tracker"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MenuView()));
                  }),
              const Padding(
                padding: EdgeInsets.fromLTRB(12, 10, 0, 0),
                child: Text(
                  "Photo Album",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                  icon: const Icon(Icons.person,
                      size: 60, color: Color.fromARGB(255, 220, 104, 145)),
                  // label: const Text("Baby Tracker"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MenuView()));
                  }),
              const Padding(
                padding: EdgeInsets.fromLTRB(12, 10, 0, 0),
                child: Text(
                  "Vision Test",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                  icon: const Icon(Icons.person,
                      size: 60, color: Color.fromARGB(255, 220, 104, 145)),
                  // label: const Text("Baby Tracker"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MenuView()));
                  }),
              const Padding(
                padding: EdgeInsets.fromLTRB(12, 10, 0, 0),
                child: Text(
                  "Skill Development Exercises",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                  icon: const Icon(Icons.person,
                      size: 60, color: Color.fromARGB(255, 220, 104, 145)),
                  // label: const Text("Baby Tracker"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MenuView()));
                  }),
              const Padding(
                padding: EdgeInsets.fromLTRB(12, 10, 0, 0),
                child: Text(
                  "Food Recommendations",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                  icon: const Icon(Icons.person,
                      size: 60, color: Color.fromARGB(255, 220, 104, 145)),
                  // label: const Text("Baby Tracker"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MenuView()));
                  }),
              const Padding(
                padding: EdgeInsets.fromLTRB(12, 10, 0, 0),
                child: Text(
                  "Forum",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                  icon: const Icon(Icons.person,
                      size: 60, color: Color.fromARGB(255, 220, 104, 145)),
                  // label: const Text("Baby Tracker"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MenuView()));
                  }),
              const Padding(
                padding: EdgeInsets.fromLTRB(12, 10, 0, 0),
                child: Text(
                  "Product Recommendations",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                  icon: const Icon(Icons.person,
                      size: 60, color: Color.fromARGB(255, 220, 104, 145)),
                  // label: const Text("Baby Tracker"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MenuView()));
                  }),
              const Padding(
                padding: EdgeInsets.fromLTRB(12, 10, 0, 0),
                child: Text(
                  "Article Recommendations",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ]));
  }
}
