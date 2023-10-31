import 'package:flutter/material.dart';
import '../../../models/checklist_model.dart';
import '../../../services/checklist_service.dart';

final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

class Week7 extends StatefulWidget {
  const Week7({Key? key}) : super(key: key);

  @override
  _Week7State createState() => _Week7State();
}

class _Week7State extends State<Week7> {
  //FirstPage({Key? key}) : super(key: key);
  // final Map<String, bool> expansionStates = {};
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

  // final service = ChecklistService('http://localhost:5154/');

  late Future<List<Checklists>> checklist1;
  late Future<List<Checklists>> _week7;

  @override
  void initState() {
    super.initState();
    checklist1 = ChecklistService.getChecklist('64cbb52cf2083327515c7058');
    _week7 = ChecklistService.fetchWeek2();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Checklists>>(
      future: _week7,
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
          final week7 = snapshot.data!;
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(children: [
                ExpansionPanelList(
                  expansionCallback: (panelIndex, isExpanded) {
                    setState(() {
                      // final checklist = newborns[panelIndex].panel;
                      // final id = (checklist.id ?? "0");
                      // expansionStates[id] = !isExpanded;
                      expanded[int.parse(week7[panelIndex].panel ?? "0")] =
                          isExpanded;
                    });
                  },
                  animationDuration: const Duration(seconds: 2),
                  //animation duration while expanding/collapsing

                  children: week7.map((data) {
                    // final id = newborn.id ?? "0";
                    // final isExpanded = expansionStates[id] ?? false;
                    return ExpansionPanel(
                        headerBuilder: (context, isOpen) {
                          return Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(data.category ?? 'Default Category',
                                  style: const TextStyle(fontSize: 16)));
                        },
                        body: Container(
                            padding: const EdgeInsets.all(20),
                            color: const Color.fromARGB(255, 250, 219, 219),
                            width: double.infinity,
                            child: Column(
                              children: data.instructions.map((instruction) {
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
                        isExpanded: expanded[int.parse(data.panel ?? "0")]);
                    // isExpanded: isExpanded);
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
