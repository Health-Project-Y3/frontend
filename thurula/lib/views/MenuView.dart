import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:thurula/views/widgets/wave_widget.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'HomeView.dart';
import 'Question2View.dart';
// import 'package:provider/provider.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    // final model = Provider.of<HomeModel>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Welcome Page'),
        ),
        body: GridView.count(crossAxisCount: 3, children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: IconButton(
                    icon: const Icon(Icons.baby_changing_station,
                        size: 60, color: Color.fromARGB(255, 220, 104, 145)),
                    // label: const Text("Baby Tracker"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MenuView()));
                    }),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(15, 3, 0, 0),
                child: Center(
                    child: Text("Baby Tracker",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold))),
              )
            ],
          ),
          IconButton(
              icon: const Icon(
                Icons.person,
                size: 60,
                color: const Color.fromARGB(255, 220, 104, 145),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MenuView()));
              }),
          IconButton(
              icon: const Icon(
                Icons.person,
                size: 60,
                color: const Color.fromARGB(255, 220, 104, 145),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MenuView()));
              }),
          IconButton(
              icon: const Icon(
                Icons.person,
                size: 60,
                color: const Color.fromARGB(255, 220, 104, 145),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MenuView()));
              }),
          IconButton(
              icon: const Icon(
                Icons.person,
                size: 60,
                color: const Color.fromARGB(255, 220, 104, 145),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MenuView()));
              })
        ]));
  }
}
