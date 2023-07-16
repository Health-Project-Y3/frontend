import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:thurula/views/widgets/graphs/Point.widget.dart';

class LineChartWidget extends StatelessWidget {
  final List<Point> points;
  const LineChartWidget(this.points, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.75,
      child: LineChart(LineChartData(
        gridData: const FlGridData(
          show: false,
        ),
        titlesData:  const FlTitlesData(
          leftTitles:  AxisTitles(axisNameWidget:Text('Length(cm)'),sideTitles: SideTitles(showTitles: true)),
          bottomTitles: AxisTitles(axisNameWidget:Text('Weeks'), sideTitles: SideTitles(showTitles: true)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),



        lineBarsData: [
          LineChartBarData(
            spots: points.map((point) {
              return FlSpot(point.x, point.y);
            }).toList(),
            isCurved: true,
            color: Colors.deepPurple,
            dotData: const FlDotData(
              show: true,
            ),
          ),
          LineChartBarData(
            spots: points.map((point) {
              return FlSpot(point.x, point.y+20);
            }).toList(),
            isCurved: true,
            color: Colors.yellow,
            dotData: const FlDotData(
              show: true,
            ),
          ),
          LineChartBarData(
            spots: points.map((point) {
              return FlSpot(point.x, point.y-20);
            }).toList(),
            isCurved: true,
            color: Colors.blue
            ,
            dotData: const FlDotData(
              show: true,
            ),
          )
        ],
      )),
    );
  }
}
