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
  double maxX = 24;
  double minY = 40;
  double maxY = 100;
  double scaleFactor = 1.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: 1000,
          height: 400,
          child: LineChart(
            LineChartData(
              lineTouchData: const LineTouchData(enabled: false),
              minX: minX,
              maxX: maxX,
              minY: minY,
              maxY: maxY,
              gridData: const FlGridData(
                show: true,
              ),
              titlesData: const FlTitlesData(
                leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  interval: 5,
                )),
                bottomTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: widget.dataList[0].map((point) {
                    return FlSpot(point.x, point.y);
                  }).toList(),
                  isCurved: true,
                  color: const Color.fromARGB(110, 185, 2, 2),
                  dotData: FlDotData(
                    show: false,
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
                  color: const Color.fromARGB(109, 185, 157, 2),
                  dotData: FlDotData(
                    show: false,
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
                  color: const Color.fromARGB(108, 14, 185, 2),
                  dotData: FlDotData(
                    show: false,
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
                  color: const Color.fromARGB(109, 185, 157, 2),
                  dotData: FlDotData(
                    show: false,
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
                  color: const Color.fromARGB(110, 185, 2, 2),
                  dotData: FlDotData(
                    show: false,
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
                  spots: widget.dataList[5].map((point) {
                    return FlSpot(point.x, point.y);
                  }).toList(),
                  isCurved: true,
                  color: const Color.fromARGB(255, 0, 0, 0),
                  dotData: FlDotData(
                    show: false,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
