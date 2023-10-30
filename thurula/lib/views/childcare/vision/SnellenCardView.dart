import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:thurula/services/eye_check_service.dart';

final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

// import 'package:provider/provider.dart';
class SnellenCardView extends StatefulWidget {
  const SnellenCardView({Key? key}) : super(key: key);

  @override
  _SnellenCardViewState createState() => _SnellenCardViewState();
}

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPage createState() => _FirstPage();
}

class _SnellenCardViewState extends State<SnellenCardView>
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
      '1 month',
      '2-3 months',
      '5-6 months',
    ];

    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Row(children: [Text('Snellen Card Test')]),
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
                children: [const FirstPage(), SecondPage(), ThirdPage()],
              ),
            ),
          ),
        ));
  }
}

class _FirstPage extends State<FirstPage> {
  // FirstPage({Key? key}) : super(key: key);

  late final TextEditingController babyIdController = TextEditingController();
  late final TextEditingController checkeddateController =
      TextEditingController();
  late final TextEditingController scoreController = TextEditingController();

  late final String _localPath;
  late final bool _permissionReady;
  late final TargetPlatform? platform = TargetPlatform.android;

  // final List<String> list = [
  //   "At 1 month, babies still prefer focusing on bright objects within a foot in front of them",
  //   "They can see distance (not as clearly) but prefer near objects.",
  //   "This is typically the same distance between their eyes and their parent's faces.",
  //   "You should aim to keep the black and white flashcards in an area that is near to your baby's face",
  //   "Choosing a distance that is similar to the distance between baby's eyes and your face will produce the best results",
  // ];

  final List<String> list = [
    "Have your child sit in the chair 10 feet from the chart, holding the cover over one eye without applying any pressure. Do not let the child peek. A second person may be needed to hold the cover in place and watch for peeking. If your child wears glasses, he or she should wear them during the test.",
    "If the chart seems too dark to see clearly, use the flashlight to illuminate the test letters.",
    "Point at each of the Es, starting with the largest. Have your child point in the direction the E is pointing."
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

  String? eyescore;
  String? message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
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
                        "$_localPath/filename.jpg");
                    print("Download Completed.");
                  } catch (e) {
                    print("Download Failed.\n\n$e");
                  }
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.5)),
                padding: const EdgeInsets.all(8),
                child: const Icon(Icons.download, color: Colors.black),
              )),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
          child: Card(
              elevation: 20,
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Column(
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
              )),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
          child: Text(
            "The value that is observed: ",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 18),
          ),
        ),
        RadioListTile(
          title: const Text("20/100"),
          value: "100",
          groupValue: eyescore,
          onChanged: (value) {
            setState(() {
              eyescore = value.toString();
            });
          },
        ),
        RadioListTile(
          title: const Text("20/70"),
          value: "70",
          groupValue: eyescore,
          onChanged: (value) {
            setState(() {
              eyescore = value.toString();
            });
          },
        ),
        RadioListTile(
          title: const Text("20/50"),
          value: "50",
          groupValue: eyescore,
          onChanged: (value) {
            setState(() {
              eyescore = value.toString();
            });
          },
        ),
        RadioListTile(
            title: const Text("20/40"),
            value: "40",
            groupValue: eyescore,
            onChanged: (value) {
              setState(() {
                eyescore = value.toString();
              });
            }),
        RadioListTile(
          title: const Text("20/30"),
          value: "30",
          groupValue: eyescore,
          onChanged: (value) {
            setState(() {
              eyescore = value.toString();
            });
          },
        ),
        ElevatedButton(
          onPressed: () async {
            if (eyescore == null) {
              ErrorMessage(context);
            } else {
              QuickMessage(context, eyescore);
              var newuser = await EyeCheckupService.create_eyecheck(
                  "64a9cb10ec5c9834ff73fc36", DateTime.now(), eyescore);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 220, 104, 145),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          child: const Text("Enter"),
        ),
      ],
    )));
  }

  void ErrorMessage(BuildContext context) {
    showDialog(
      context: context, // You need a BuildContext for this
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error Message"),
          content: Text("Select from above before entering."),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

void QuickMessage(BuildContext context, String? eyescore) {
  print(eyescore);
  String message;
  if (int.parse(eyescore!) <= 30) {
    message = "Take your child to a doctor";
  } else if (int.parse(eyescore) <= 40) {
    message = "Do the test every week";
  } else {
    message = "Your child has good eyesight";
  }

  // Show a dialog with the message
  showDialog(
    context: context, // You need a BuildContext for this
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Results/Further Considerations"),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
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
                        "$_localPath/filename.jpg");
                    print("Download Completed.");
                  } catch (e) {
                    print("Download Failed.\n\n$e");
                  }
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.5)),
                padding: const EdgeInsets.all(8),
                child: const Icon(Icons.download, color: Colors.black),
              )),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
          child: Card(
              elevation: 20,
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
                      child: SizedBox(
                        height: 200,
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
              )),
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
                        "$_localPath/filename.jpg");
                    print("Download Completed.");
                  } catch (e) {
                    print("Download Failed.\n\n$e");
                  }
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.5)),
                padding: const EdgeInsets.all(8),
                child: const Icon(Icons.download, color: Colors.black),
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              elevation: 20,
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
                      child: SizedBox(
                        height: 150,
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
              )),
        ),
      ],
    ));
  }
}
