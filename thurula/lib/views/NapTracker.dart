import 'package:flutter/material.dart';

class NapTracker extends StatelessWidget {
  const NapTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48.0), // height of  TabBar
              child: Container(
                color: const Color.fromARGB(255, 220, 104, 145),
                child: const TabBar(
                  tabs: [
                    Tab(
                      text: "Nap Details",
                    ),
                    Tab(
                      text: "Start Nap",
                    ),
                    Tab(
                      text: "Add Nap Details",
                    ),
                  ],
                ),
              ),
            ),
            title: const Text('Nap Tracker'),
          ),
        ),
      ),
    );
  }
}