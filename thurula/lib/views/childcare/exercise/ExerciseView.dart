import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../MenuView.dart';

final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

// import 'package:provider/provider.dart';
class ExerciseView extends StatefulWidget {
  ExerciseView({Key? key}) : super(key: key);

  @override
  _ExerciseViewState createState() => _ExerciseViewState();
}

class Newborn extends StatefulWidget {
  Newborn({Key? key}) : super(key: key);

  @override
  _NewbornState createState() => _NewbornState();
}

class _ExerciseViewState extends State<ExerciseView>
    with SingleTickerProviderStateMixin {
  //const SnellenCardView({Key? key}) : super(key: key);
  //SnellenCardView({super.key});

  late final TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 21, vsync: this);
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
      '2 Months',
      '9 Weeks',
      '10 Weeks',
      '11 Weeks',
      '3 Months',
      '4 Months',
      '5 Months',
      '6 Months',
      '7 Months',
      '8 Months',
      '9 Months',
      '10 Months',
      '11 Months',
      '1 Year'
    ];

    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Row(children: [Text('Check list')]),
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
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabs: [
                for (final tab in tabs) Tab(text: tab),
              ],
            ),
          ),
          body: Navigator(
            key: _navKey,
            onGenerateRoute: (_) => MaterialPageRoute(
              builder: (_) => TabBarView(
                controller: _tabController,
                children: [
                  Newborn(),
                  Week2(),
                  Week3(),
                  Month1(),
                  Week5(),
                  Week6(),
                  Week7(),
                  Month2(),
                  Week9(),
                  Week10(),
                  Week11(),
                  Month3(),
                  Month4(),
                  Month5(),
                  Month6(),
                  Month7(),
                  Month8(),
                  Month9(),
                  Month10(),
                  Month11(),
                  Year1(),
                ],
              ),
            ),
          ),
        ));
  }
}

class _NewbornState extends State<Newborn> {
  //FirstPage({Key? key}) : super(key: key);

  final List<bool> expanded = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  final List<String> milestones = [
    "Your baby may have a spontaneous reflexive smile",
    "Your baby controls arms and legs on either side of his or her body equally well",
    "Your little one can focus briefly on objects near the face, and up to about 12 to 15 inches away",
    "Your baby shows reflexes like sulking and rooting",
    "Choosing a distance that is similar to the distance between baby's eyes and your face will produce the best results",
  ];

  final List<String> stimulation = [
    "Help your baby eye muscle strengthen by moving your head from side to side, slowly. See if baby's eyes follow you.",
    "Select toys that have high-contrast colors, such as black, white and red. Your baby can see these better than multi-colored objects",
    "Keep talking to and loving your little one, knowing that your're fueling both his/her emotional and cognitive development"
  ];

  final List<String> homecare = [
    "Remember that your baby is still quite fragile. Hold his/her neck when you carry or bath him/her.",
    "Be extra gentle around soft spot on baby's head, or the fontanelle",
    "Check your baby's diaper often to ensure he/she is getting enough to eat."
  ];

  final List<String> immunization = ["No vaccinations"];

  final List<String> nutrition = [
    "Feed on demand. Watch for signs of hunger: rooting, head-bobbing, fist-sucking, mouth-fluttering"
  ];

  final List<String> contact = [
    "If your baby has an oozy umbilical stump that is also smelly.",
    "If your baby is running even the slightest of fevers(over 37 degrees Celsius)",
    "If your baby has shrunken fontanelle (the soft spot on the head) - this could be a sign of dehydration.",
    "If baby has had any kind of fall"
  ];

  final List<String> mum = [
    "Ensure you have plenty of support during these early days of motherhood",
    "Consider a post-natal massage",
  ];

  final List<String> reminders = [
    "Swaddling helps keep baby calm and asleep when he/she is startled.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          ExpansionPanelList(
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  expanded[panelIndex] = !isExpanded;
                });
              },
              animationDuration: const Duration(seconds: 2),
              //animation duration while expanding/collapsing
              children: [
                ExpansionPanel(
                    headerBuilder: (context, isOpen) {
                      return const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text("General Baby Milestones"));
                    },
                    body: Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.redAccent[100],
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 250,
                              child: ListView.builder(
                                  itemCount: milestones.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return Column(
                                      children: [
                                        Text(
                                          "${index + 1}.${milestones[index]}",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        const Divider(
                                          color: Colors.black,
                                        )
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        )),
                    isExpanded: expanded[0]),
                ExpansionPanel(
                    headerBuilder: (context, isOpen) {
                      return const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text("Stimulation"));
                    },
                    body: Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.redAccent[100],
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 250,
                              child: ListView.builder(
                                  itemCount: stimulation.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return Column(
                                      children: [
                                        Text(
                                          "${index + 1}.${stimulation[index]}",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        const Divider(
                                          color: Colors.black,
                                        )
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        )),
                    isExpanded: expanded[1]),
                ExpansionPanel(
                    headerBuilder: (context, isOpen) {
                      return const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text("At-home care for your little one"));
                    },
                    body: Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.redAccent[100],
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 250,
                              child: ListView.builder(
                                  itemCount: homecare.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return Column(
                                      children: [
                                        Text(
                                          "${index + 1}.${homecare[index]}",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        const Divider(
                                          color: Colors.black,
                                        )
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        )),
                    isExpanded: expanded[2]),
                ExpansionPanel(
                    headerBuilder: (context, isOpen) {
                      return const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text("Immunizations"));
                    },
                    body: Container(
                        padding: const EdgeInsets.all(20),
                        color: Color.fromARGB(255, 255, 238, 236),
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 60,
                              child: ListView.builder(
                                  itemCount: immunization.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return Column(
                                      children: [
                                        Text(
                                          immunization[index],
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        )),
                    isExpanded: expanded[3]),
                ExpansionPanel(
                    headerBuilder: (context, isOpen) {
                      return const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text("Your Child's Nutrition"));
                    },
                    body: Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.redAccent[100],
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 80,
                              child: ListView.builder(
                                  itemCount: nutrition.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return Column(
                                      children: [
                                        Text(
                                          "${index + 1}.${nutrition[index]}",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        )),
                    isExpanded: expanded[4]),
                ExpansionPanel(
                    headerBuilder: (context, isOpen) {
                      return const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text("Contact your doctor if..."));
                    },
                    body: Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.redAccent[100],
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 250,
                              child: ListView.builder(
                                  itemCount: contact.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return Column(
                                      children: [
                                        Text(
                                          "${index + 1}.${contact[index]}",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        const Divider(
                                          color: Colors.black,
                                        )
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        )),
                    isExpanded: expanded[5]),
                ExpansionPanel(
                    headerBuilder: (context, isOpen) {
                      return const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text("Mum's Health and Well-being"));
                    },
                    body: Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.redAccent[100],
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 250,
                              child: ListView.builder(
                                  itemCount: mum.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return Column(
                                      children: [
                                        Text(
                                          "${index + 1}.${mum[index]}",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        const Divider(
                                          color: Colors.black,
                                        )
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        )),
                    isExpanded: expanded[6]),
                ExpansionPanel(
                    headerBuilder: (context, isOpen) {
                      return const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text("Reminders"));
                    },
                    body: Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.redAccent[100],
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 250,
                              child: ListView.builder(
                                  itemCount: reminders.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return Column(
                                      children: [
                                        Text(
                                          "${index + 1}.${reminders[index]}",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        const Divider(
                                          color: Colors.black,
                                        )
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        )),
                    isExpanded: expanded[7]),
              ]),
        ],
      ),
    ));
  }
}

class Week2 extends StatelessWidget {
  Week2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Week3 extends StatelessWidget {
  Week3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Month1 extends StatelessWidget {
  Month1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Week5 extends StatelessWidget {
  Week5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Week6 extends StatelessWidget {
  Week6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Week7 extends StatelessWidget {
  Week7({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Month2 extends StatelessWidget {
  Month2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Week9 extends StatelessWidget {
  Week9({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Week10 extends StatelessWidget {
  Week10({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Week11 extends StatelessWidget {
  Week11({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Month3 extends StatelessWidget {
  Month3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Month4 extends StatelessWidget {
  Month4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Month5 extends StatelessWidget {
  Month5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Month6 extends StatelessWidget {
  Month6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Month7 extends StatelessWidget {
  Month7({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Month8 extends StatelessWidget {
  Month8({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Month9 extends StatelessWidget {
  Month9({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Month10 extends StatelessWidget {
  Month10({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Month11 extends StatelessWidget {
  Month11({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}

class Year1 extends StatelessWidget {
  Year1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [Text("hi")],
    ));
  }
}
