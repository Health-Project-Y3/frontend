import 'package:flutter/material.dart';
import 'package:thurula/views/child_home_view.dart';
import 'package:thurula/views/pregnancy_home_view.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 227, 227, 227),
          // appbar
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 220, 104, 145),
            title: TabBar(
              tabs: const [
                Tab(
                  text: "Pregnancy",
                ),
                Tab(
                  text: "Childcare",
                ),
              ],
              // text color of indicator pink
              labelColor: const Color.fromARGB(255, 220, 104, 145),
              // text color of non-selected tabs
              unselectedLabelColor: Colors.white,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 250, 238, 244),
              ),
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, bottom: 5.0, top: 5.0),
            ),
          //   logout button
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  Navigator.of(context).pop(); // Example: Navigate back
                },
              ),
            ],
          ),
          body: const Column(
            children: [
              Expanded(
                child: TabBarView(
                  children: [PregnancyHomeView(), ChildHomeView()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
