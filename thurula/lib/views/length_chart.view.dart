import 'package:flutter/material.dart';
import 'package:thurula/views/widgets/graphs/LineChart.widget.dart';
import 'package:thurula/views/widgets/graphs/Point.widget.dart';

class LengthChartView extends StatefulWidget {
  const LengthChartView({super.key});

  @override
  State<LengthChartView> createState() => _LengthChartViewState();
}

class _LengthChartViewState extends State<LengthChartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Length Chart'),
        ),
        //use padding to add space between the widgets
        body: Center(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                child: Column(children: <Widget>[
                  const Text(
                    'Length Chart',
                    style: TextStyle(fontSize: 30),
                  ),
                  Container(
                      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: LineChartWidget(getPoints())),
                ]))));
  }
}
