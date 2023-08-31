import 'package:flutter/material.dart';
import 'package:thurula/services/baby_length_service.dart';
import 'package:thurula/views/widgets/graphs/baby_length_chart_widget.dart';

import 'widgets/graphs/point_widget.dart';

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
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 220, 104, 145),
          title: const Text(
            'Length Chart',
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        //use padding to add space between the widgets
        body: Center(
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: SizedBox(
                    width: 400,
                    height: 650,
                    child: FutureBuilder(
                      //TODO change the temporary id to the actual id
                      future: loadData("male"),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          print(snapshot.data);
                          print(snapshot.data.runtimeType);
                          return Container(
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: BabyLengthChartWidget(snapshot.data));
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                ),
              ),
        ])));
  }
}
