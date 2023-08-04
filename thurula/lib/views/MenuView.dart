import 'package:flutter/material.dart';
import 'package:thurula/views/ChildCareMenuView.dart';
import 'package:thurula/views/PregnancyMenuView.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

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
                      text: "Pregnancy",
                    ),
                    Tab(
                      text: "Child Care",
                    ),
                  ],
                ),
              ),
            ),
            title: const Text('Explore Thurula'),
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
          body: const TabBarView(
            children: [PregnancyMenuView(), ChildCareMenuView()],
          ),
        ),
      ),
    );
  }
}
