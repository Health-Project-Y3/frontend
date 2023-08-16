import 'package:flutter/material.dart';
import 'package:thurula/views/child_home_view.dart';
import 'package:thurula/views/pregnancy_home_view.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key, required this.username});

  final String username;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 227, 227, 227),
          body: Column(
            children: [
              Container(
                color: const Color.fromARGB(255, 220, 104, 145),
                child: const TabBar(
                  tabs: [
                    Tab(
                      text: "Pregnancy",
                    ),
                    Tab(
                      text: "Child Care",
                    ),
                  ],
                ),
              ),
              const Expanded(
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
