import 'package:flutter/material.dart';
import 'package:thurula/views/childcare/exercise/week3.dart';
import 'package:thurula/views/childcare/exercise/week2.dart';
import 'package:thurula/views/childcare/exercise/month1.dart';
import 'package:thurula/views/childcare/exercise/week5.dart';
import 'package:thurula/views/childcare/exercise/week6.dart';
import 'package:thurula/views/childcare/exercise/week7.dart';
import '../../../models/checklist_model.dart';
import '../../../services/checklist_service.dart';
import '../../widgets/navbar_widget.dart';

final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

// import 'package:provider/provider.dart';
class ExerciseView extends StatefulWidget {
  const ExerciseView({Key? key}) : super(key: key);

  @override
  _ExerciseViewState createState() => _ExerciseViewState();
}

class Newborn extends StatefulWidget {
  const Newborn({Key? key}) : super(key: key);

  @override
  _NewbornState createState() => _NewbornState();
}

// class Week2 extends StatefulWidget {
//   const Week2({Key? key}) : super(key: key);

//   @override
//   _Week2State createState() => _Week2State();
// }

// class Week3 extends StatefulWidget {
//   const Week3({Key? key}) : super(key: key);

//   @override
//   _Week3State createState() => _Week3State();
// }

class _ExerciseViewState extends State<ExerciseView>
    with SingleTickerProviderStateMixin {
  //const SnellenCardView({Key? key}) : super(key: key);
  //SnellenCardView({super.key});

  late final TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 7, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final model = Provider.of<HomeModel>(context);

    final tabs = [
      'Newborn',
      '2 Weeks',
      '3 Weeks',
      '1 Month',
      '5 Weeks',
      '6 Weeks',
      '7 Weeks',
      // '2 Months',
      // '9 Weeks',
      // '10 Weeks',
      // '11 Weeks',
      // '3 Months',
      // '4 Months',
      // '5 Months',
      // '6 Months',
      // '7 Months',
      // '8 Months',
      // '9 Months',
      // '10 Months',
      // '11 Months',
      // '1 Year'
    ];

    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Row(children: [Text('Check list')]),
            backgroundColor: const Color.fromARGB(255, 220, 104, 145),
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabs: [
                for (final tab in tabs) Tab(text: tab),
              ],
              indicatorColor: Colors.white,
            ),
          ),
          body: Navigator(
            key: _navKey,
            onGenerateRoute: (_) => MaterialPageRoute(
              builder: (_) => TabBarView(
                controller: _tabController,
                children: const [
                  Newborn(),
                  Week2(),
                  Week3(),
                  Month1(),
                  Week5(),
                  Week6(),
                  Week7(),
                  // Month2(),
                  // Week9(),
                  // Week10(),
                  // Week11(),
                  // Month3(),
                  // Month4(),
                  // Month5(),
                  // Month6(),
                  // Month7(),
                  // Month8(),
                  // Month9(),
                  // Month10(),
                  // Month11(),
                  // Year1(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: const CreateBottomNavigationBar(pageIndex: 1),
        ));
  }
}

class _NewbornState extends State<Newborn> {
  final List<bool> expanded = [false, false, false, false, false, false, false];

  late Future<List<Checklists>> checklist1;
  late Future<List<Checklists>> _newborns;

  @override
  void initState() {
    super.initState();
    checklist1 = ChecklistService.getChecklist('64cbb52cf2083327515c7058');
    _newborns = ChecklistService.fetchNewborns();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Checklists>>(
      future: _newborns,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 10.0,
            width: 10.0,
            child: Center(
                child: CircularProgressIndicator(
              //   color
              color: Color.fromARGB(255, 220, 104, 145),
            )),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final newborns = snapshot.data!;
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(children: [
                ExpansionPanelList(
                  expansionCallback: (panelIndex, isExpanded) {
                    setState(() {
                      expanded[int.parse(newborns[panelIndex].panel ?? "0")] =
                          isExpanded;
                    });
                  },
                  animationDuration: const Duration(seconds: 2),
                  //animation duration while expanding/collapsing

                  children: newborns.map((newborn) {
                    return ExpansionPanel(
                        headerBuilder: (context, isOpen) {
                          return Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                  newborn.category ?? 'Default Category',
                                  style: const TextStyle(fontSize: 16)));
                        },
                        body: Container(
                            padding: const EdgeInsets.all(20),
                            color: const Color.fromARGB(255, 250, 219, 219),
                            width: double.infinity,
                            child: Column(
                              children: newborn.instructions.map((instruction) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 5, 0),
                                          child: Icon(
                                            Icons.tips_and_updates,
                                            size: 22,
                                            color: Color.fromARGB(
                                                255, 212, 160, 178),
                                          ),
                                        ),
                                        Flexible(
                                            child: Text(
                                          instruction.instruction ??
                                              'Default Instruction',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                            height: 1.5,
                                          ),
                                        )),
                                      ],
                                    ),
                                  ],
                                );
                              }).toList(),
                            )),
                        isExpanded: expanded[int.parse(newborn.panel ?? "0")]);
                  }).toList(),
                )
              ]),
            ),
          );
        } else {
          return const Text('No data available.');
        }
      },
    );
  }
}

class Month2 extends StatelessWidget {
  const Month2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Week9 extends StatelessWidget {
  const Week9({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Week10 extends StatelessWidget {
  const Week10({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Week11 extends StatelessWidget {
  const Week11({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Month3 extends StatelessWidget {
  const Month3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Month4 extends StatelessWidget {
  const Month4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Month5 extends StatelessWidget {
  const Month5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Month6 extends StatelessWidget {
  const Month6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Month7 extends StatelessWidget {
  const Month7({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Month8 extends StatelessWidget {
  const Month8({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Month9 extends StatelessWidget {
  const Month9({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Month10 extends StatelessWidget {
  const Month10({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Month11 extends StatelessWidget {
  const Month11({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Year1 extends StatelessWidget {
  const Year1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}
