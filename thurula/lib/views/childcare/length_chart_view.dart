import 'package:flutter/material.dart';
import 'package:thurula/services/baby_length_service.dart';
import 'package:thurula/views/widgets/graphs/baby_length_chart_widget.dart';

import '../widgets/graphs/point_widget.dart';

class LengthChartView extends StatefulWidget {
  const LengthChartView({super.key});

  @override
  State<LengthChartView> createState() => _LengthChartViewState();
}

Future<List<List<Point>>> loadData(gender, {id = ""}) async {
  List<List<Point>> allDataLists = [];

  allDataLists.add(await BabyLengthService().getReferenceLength(gender, 10));
  allDataLists.add(await BabyLengthService().getReferenceLength(gender, 25));
  allDataLists.add(await BabyLengthService().getReferenceLength(gender, 50));
  allDataLists.add(await BabyLengthService().getReferenceLength(gender, 75));
  allDataLists.add(await BabyLengthService().getReferenceLength(gender, 90));
  if (id != "") {
    allDataLists.add(await BabyLengthService().getBabyLength(id));
  }

  return allDataLists;
}

class _LengthChartViewState extends State<LengthChartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Length Chart'),
            backgroundColor: const Color.fromARGB(255, 220, 104, 145)),
        // use padding to add space between the widgets
        body: Center(
            child: Column(children: <Widget>[
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 20, 10),
              child: Row(children: [
                const SizedBox(
                    child: RotatedBox(
                        quarterTurns: -1,
                        child: Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Length (cm)',
                              style: TextStyle(fontSize: 16),
                              // overflow: TextOverflow.ellipsis,
                            )))),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 20, left: 10),
                        decoration: const BoxDecoration(
                            color: Color(0xFFFED7E3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: SizedBox(
                          width: 400,
                          height: 600,
                          child: FutureBuilder(
                            //TODO change the temporary id to the actual id
                            future: loadData("male"),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                // print(snapshot.data);
                                // print(snapshot.data.runtimeType);
                                return Container(
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child:
                                        BabyLengthChartWidget(snapshot.data));
                              } else {
                                return const SizedBox(
                                  height: 10.0,
                                  width: 10.0,
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    //   color
                                    color: Color.fromARGB(255, 220, 104, 145),
                                  )),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ])),
          const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Text('Age (weeks)', style: TextStyle(fontSize: 16)),
              ))
        ])));
  }
}
