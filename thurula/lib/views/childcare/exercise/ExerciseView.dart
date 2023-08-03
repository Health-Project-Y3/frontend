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

class FirstPage extends StatefulWidget {
  FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _ExerciseViewState extends State<ExerciseView>
    with SingleTickerProviderStateMixin {
  //const SnellenCardView({Key? key}) : super(key: key);
  //SnellenCardView({super.key});

  late final TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final model = Provider.of<HomeModel>(context);

    final tabs = [
      'Newborn',
      '2-3 months',
      '5-6 months',
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
                children: [FirstPage(), SecondPage(), ThirdPage()],
              ),
            ),
          ),
        ));
  }
}

class _FirstPageState extends State<FirstPage> {
  //FirstPage({Key? key}) : super(key: key);

  final List<bool> expanded = [false, false, false, false];

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

  final List<String> immunization = [
    "Remember that your baby is still quite fragile. Hold his/her neck when you carry or bath him/her.",
    "Be extra gentle around soft spot on baby's head, or the fontanelle",
    "Check your baby's diaper often to ensure he/she is getting enough to eat."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
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
                  isExpanded: expanded[3]),
            ]),
      ],
    ));
  }
}

class SecondPage extends StatelessWidget {
  SecondPage({Key? key}) : super(key: key);
  late final String _localPath;
  late final bool _permissionReady;
  late final TargetPlatform? platform = TargetPlatform.android;

  final List<String> list = [
    "In the first 2-3 months babies eyes may not work well together and you may notice the eyes crossing or wandering.",
    "If this is constant talk to your doctor.",
    "By about 3 months old this should correct, and your baby should be able to focus and track objects and maybe reach for objects.",
  ];

  Future<bool> _checkPermission() async {
    final status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      final result = await Permission.storage.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;

    print(_localPath);
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    return "/sdcard/download/";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        // const FittedBox(
        //     fit: BoxFit.fill,
        //     child: Image(
        //         image:
        //             AssetImage('assets/images/baby vision cards 1 month.jpg'),
        //         //width: 300,
        //         height: 200)),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: InkWell(
              onTap: () async {
                _permissionReady = await _checkPermission();
                if (_permissionReady) {
                  await _prepareSaveDir();
                  print("Downloading");
                  try {
                    await Dio().download(
                        "https://en.wikipedia.org/wiki/Snellen_chart#/media/File:Snellen_chart.svg",
                        _localPath + "/" + "filename.jpg");
                    print("Download Completed.");
                  } catch (e) {
                    print("Download Failed.\n\n" + e.toString());
                  }
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.5)),
                padding: EdgeInsets.all(8),
                child: Icon(Icons.download, color: Colors.black),
              )),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
              child: SizedBox(
                height: 250,
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Text(
                        "${index + 1}.${list[index]}",
                        style: const TextStyle(fontSize: 16),
                      );
                    }),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}

class ThirdPage extends StatelessWidget {
  ThirdPage({Key? key}) : super(key: key);
  late final String _localPath;
  late final bool _permissionReady;
  late final TargetPlatform? platform = TargetPlatform.android;

  final List<String> list = [
    "They will have improvement in color vision and can recognize faces (parents) across a room",
    "Depth perception also improves at this age and reaching for objects becomes easier",
  ];

  Future<bool> _checkPermission() async {
    final status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      final result = await Permission.storage.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;

    print(_localPath);
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    return "/sdcard/download/";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        // const FittedBox(
        //     fit: BoxFit.fill,
        //     child: Image(
        //         image:
        //             AssetImage('assets/images/baby vision cards 1 month.jpg'),
        //         //width: 300,
        //         height: 200)),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: InkWell(
              onTap: () async {
                _permissionReady = await _checkPermission();
                if (_permissionReady) {
                  await _prepareSaveDir();
                  print("Downloading");
                  try {
                    await Dio().download(
                        "https://en.wikipedia.org/wiki/Snellen_chart#/media/File:Snellen_chart.svg",
                        _localPath + "/" + "filename.jpg");
                    print("Download Completed.");
                  } catch (e) {
                    print("Download Failed.\n\n" + e.toString());
                  }
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.5)),
                padding: EdgeInsets.all(8),
                child: Icon(Icons.download, color: Colors.black),
              )),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
              child: SizedBox(
                height: 250,
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Text(
                        "${index + 1}.${list[index]}",
                        style: const TextStyle(fontSize: 16),
                      );
                    }),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
