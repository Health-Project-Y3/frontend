import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:thurula/views/widgets/graphs/point_widget.dart';

class BabyLengthChartWidget extends StatefulWidget {
  final List<List<Point>> dataList;

  const BabyLengthChartWidget(this.dataList, {Key? key}) : super(key: key);

  @override
  _BabyLengthChartWidgetState createState() => _BabyLengthChartWidgetState();
}

class _BabyLengthChartWidgetState extends State<BabyLengthChartWidget> {
  double minX = 0;
  double maxX = 25;
  double minY = 40;
  double maxY = 100;
  double scaleFactor = 1.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: 1000,
        child: LineChart(
          LineChartData(
            minX: minX,
            maxX: maxX,
            minY: minY,
            maxY: maxY,
            gridData: const FlGridData(
              show: true,
            ),
            titlesData: const FlTitlesData(
              leftTitles: AxisTitles(
                  axisNameWidget: Text('Length(cm)'),
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    interval: 5,
                  )),
              bottomTitles: AxisTitles(
                  axisNameWidget: Text('Weeks'),
                  sideTitles: SideTitles(
                      showTitles: true, reservedSize: 40)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: widget.dataList[0].map((point) {
                  return FlSpot(point.x, point.y);
                }).toList(),
                isCurved: true,
                color: Colors.red,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (FlSpot spot, double? percent,
                      LineChartBarData barData, int index) {
                    return FlDotCirclePainter(
                      strokeWidth: 1.5,
                      radius: 1.5,
                      color: Colors.black,
                    );
                  },
                ),
              ),
              LineChartBarData(
                spots: widget.dataList[1].map((point) {
                  return FlSpot(point.x, point.y);
                }).toList(),
                isCurved: true,
                color: Colors.yellow,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (FlSpot spot, double? percent,
                      LineChartBarData barData, int index) {
                    return FlDotCirclePainter(
                      strokeWidth: 1.5,
                      radius: 1.5,
                      color: Colors.black,
                    );
                  },
                ),
              ),
              LineChartBarData(
                spots: widget.dataList[2].map((point) {
                  return FlSpot(point.x, point.y);
                }).toList(),
                isCurved: true,
                color: Colors.green,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (FlSpot spot, double? percent,
                      LineChartBarData barData, int index) {
                    return FlDotCirclePainter(
                      strokeWidth: 1.5,
                      radius: 1.5,
                      color: Colors.black,
                    );
                  },
                ),
              ),
              LineChartBarData(
                spots: widget.dataList[3].map((point) {
                  return FlSpot(point.x, point.y);
                }).toList(),
                isCurved: true,
                color: Colors.yellow,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (FlSpot spot, double? percent,
                      LineChartBarData barData, int index) {
                    return FlDotCirclePainter(
                      strokeWidth: 1.5,
                      radius: 1.5,
                      color: Colors.black,
                    );
                  },
                ),
              ),
              LineChartBarData(
                spots: widget.dataList[4].map((point) {
                  return FlSpot(point.x, point.y);
                }).toList(),
                isCurved: true,
                color: Colors.red,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (FlSpot spot, double? percent,
                      LineChartBarData barData, int index) {
                    return FlDotCirclePainter(
                      strokeWidth: 1.5,
                      radius: 1.5,
                      color: Colors.black,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
