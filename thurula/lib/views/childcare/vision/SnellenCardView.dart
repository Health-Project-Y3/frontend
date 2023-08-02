import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../MenuView.dart';

final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

// import 'package:provider/provider.dart';
class SnellenCardView extends StatefulWidget {
  SnellenCardView({Key? key}) : super(key: key);

  @override
  _SnellenCardViewState createState() => _SnellenCardViewState();
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

class FirstPage extends StatelessWidget {
  FirstPage({Key? key}) : super(key: key);
  late final String _localPath;
  late final bool _permissionReady;
  late final TargetPlatform? platform = TargetPlatform.android;

  final List<String> list = [
    "At 1 month, babies still prefer focusing on bright objects within a foot in front of them",
    "They can see distance (not as clearly) but prefer near objects.",
    "This is typically the same distance between their eyes and their parent's faces.",
    "You should aim to keep the black and white flashcards in an area that is near to your baby's face",
    "Choosing a distance that is similar to the distance between baby's eyes and your face will produce the best results",
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
