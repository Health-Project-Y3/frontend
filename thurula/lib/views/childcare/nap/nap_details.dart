import 'package:flutter/material.dart';
import 'package:thurula/views/childcare/child_home_view.dart';
import 'package:thurula/views/childcare/nap/nap_records.dart';
import 'package:thurula/services/naps_service.dart';
import 'package:thurula/models/naptimes_model.dart';
import 'dart:ui';

class NapDetails extends StatefulWidget {
  @override
  _NapDetailsState createState() => _NapDetailsState();
}

class _NapDetailsState extends State<NapDetails> {
  Future<List<NapTimes>>? _napRecordsFuture;
  List<NapTimes> napRecords = [];

  @override
  void initState() {
    super.initState();
    _napRecordsFuture = NapService.getBabyNaps('64b01605b55b765169e1c9b6');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 220, 104, 145),
        title: const Text(
          'Baby Nap Details',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: FutureBuilder<List<NapTimes>>(
        future: _napRecordsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No nap records found.'));
          } else {
            napRecords = snapshot.data!;
            final sleepDurationByDay = _calculateSleepDurationByDay(napRecords);
            final List<DataPoint> dataPoints = sleepDurationByDay.entries
                .map((entry) => DataPoint(
              x: entry.key, // Use the DateTime representing the day
              y: entry.value,
            ))
                .toList();

            int totalNapsToday = _calculateTotalNapsToday(napRecords);
            double totalSleepDurationMinutes =
            _calculateTotalSleepDurationToday(napRecords);
            String totalSleepDurationFormatted =
            _formatDuration(totalSleepDurationMinutes);

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      "Mary's Nap Details",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 88, 119, 161),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NapStatCard(
                          title: 'Total Naps Today',
                          value: totalNapsToday.toString(),
                        ),
                        SizedBox(height: 5),
                        NapStatCard(
                          title: 'Total Sleep Duration Today',
                          value: totalSleepDurationFormatted,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NapRecords(),
                            ),
                          );
                        },
                        child: const Text('All Nap Details'),
                      ),
                    ),
                    Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: double.infinity,
                          height: 240,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 50.0,
                                  ),
                                  child: Container(
                                    width: dataPoints.length * 80,
                                    height: 200,
                                    child: CustomPaint(
                                      size: Size(
                                          dataPoints.length * 80, 200),
                                      painter: ChartPainter(dataPoints),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  int _calculateTotalNapsToday(List<NapTimes> records) {
    DateTime today = DateTime.now();
    return records.where((record) {
      return record.startTime!.year == today.year &&
          record.startTime!.month == today.month &&
          record.startTime!.day == today.day;
    }).length;
  }

  double _calculateTotalSleepDurationToday(List<NapTimes> records) {
    DateTime today = DateTime.now();
    double totalDuration = 0;
    records.forEach((record) {
      if (record.startTime!.year == today.year &&
          record.startTime!.month == today.month &&
          record.startTime!.day == today.day) {
        totalDuration +=
            record.endTime!.difference(record.startTime!).inMinutes.toDouble();
      }
    });
    return totalDuration;
  }

  String _formatDuration(double minutes) {
    int hours = (minutes / 60).floor();
    int remainingMinutes = (minutes % 60).round();
    return '$hours hours ' 'and $remainingMinutes minutes';
  }

  Map<DateTime, double> _calculateSleepDurationByDay(List<NapTimes> records) {
    final Map<DateTime, double> sleepDurationByDay = {};
    records.forEach((record) {
      final day = DateTime(
        record.startTime!.year,
        record.startTime!.month,
        record.startTime!.day,
      );
      final duration = record.endTime!.difference(record.startTime!).inMinutes;
      sleepDurationByDay.update(
        day,
            (value) => value + duration.toDouble(),
        ifAbsent: () => duration.toDouble(),
      );
    });
    return sleepDurationByDay;
  }
}

class NapStatCard extends StatelessWidget {
  final String title;
  final String value;

  const NapStatCard({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 220, 104, 145),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartPainter extends CustomPainter {
  final List<DataPoint> dataPoints;

  ChartPainter(this.dataPoints);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2;

    final maxY =
    dataPoints.map((point) => point.y).reduce((a, b) => a > b ? a : b);

    final xAxisStart = Offset(0, size.height);
    final xAxisEnd = Offset(size.width, size.height);
    final yAxisStart = Offset(0, 0);
    final yAxisEnd = Offset(0, size.height);

    canvas.drawLine(xAxisStart, xAxisEnd, paint);
    canvas.drawLine(yAxisStart, yAxisEnd, paint);

    final yLabelOffset = Offset(-40, -40);
    final yLabelStyle = TextStyle(
      color: Colors.black,
      fontSize: 12,
    );
    final yLabelPainter = TextPainter(
      text: TextSpan(
        text: 'Duration (hours)',
        style: yLabelStyle,
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    yLabelPainter.layout();
    yLabelPainter.paint(canvas, yLabelOffset);

    final xLabelOffset = Offset(0, 10);
    final xLabelStyle = TextStyle(
      color: Colors.black,
      fontSize: 12,
    );
    for (var i = 0; i < dataPoints.length; i++) {
      final x = (size.width / dataPoints.length) * i;
      final labelText = _formatDateTimeForXAxis(dataPoints[i].x);
      final xLabelPainter = TextPainter(
        text: TextSpan(
          text: labelText,
          style: xLabelStyle,
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      xLabelPainter.layout();
      xLabelPainter.paint(canvas, Offset(x, size.height) + xLabelOffset);
    }

    // Add y-axis labels
    final yLabelStep = maxY / 5;
    for (var i = 0; i <= 5; i++) {
      final y = size.height - (size.height * (i / 5));
      final labelText = _formatDurationForChart(yLabelStep * i);
      final yLabelPainter = TextPainter(
        text: TextSpan(
          text: labelText,
          style: yLabelStyle,
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      yLabelPainter.layout();
      yLabelPainter.paint(canvas, Offset(-40, y - 6));
    }

    // Add label to bottom right corner
    final dayLabelOffset = Offset(
      size.width - 500,
      size.height - yLabelStyle.fontSize! * -3,
    );
    final dayLabelStyle = TextStyle(
      color: Colors.black,
      fontSize: 12,
    );
    final dayLabelPainter = TextPainter(
      text: TextSpan(
        text: 'Day (mm:dd)',
        style: dayLabelStyle,
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    dayLabelPainter.layout();
    dayLabelPainter.paint(canvas, dayLabelOffset);

    for (var i = 0; i < dataPoints.length - 1; i++) {
      final x1 = (size.width / dataPoints.length) * i;
      final y1 = size.height - (size.height * (dataPoints[i].y / maxY));
      final x2 = (size.width / dataPoints.length) * (i + 1);
      final y2 = size.height - (size.height * (dataPoints[i + 1].y / maxY));
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }
  }

  String _formatDateTimeForXAxis(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}';
  }

  String _formatDurationForChart(double minutes) {
    if (minutes == 0) {
      return '0 Hr';
    }
    int hours = (minutes / 60).floor();
    return '$hours Hr';
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class DataPoint {
  final DateTime x;
  final double y;

  DataPoint({required this.x, required this.y});
}
