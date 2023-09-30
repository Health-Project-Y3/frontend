import 'package:flutter/material.dart';
import 'package:thurula/views/childcare/length_chart_view.dart';
import 'package:thurula/views/childcare/weight_chart_view.dart';

class GrowthChartView extends StatelessWidget {
  const GrowthChartView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 220, 104, 145),
            // backgroundColor: const Color.fromARGB(255, 227, 227, 227),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              onPressed: () {
                // Handle back button press here
                Navigator.of(context).pop(); // Example: Navigate back
              },
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50.0), // height of  TabBar
              child: Container(
                color: Color.fromARGB(255, 220, 104, 145),
                child: const TabBar(
                  tabs: [
                    Tab(
                      text: "Length Chart",
                    ),
                    Tab(
                      text: "Weight Chart",
                    )
                  ],
                  indicatorColor: Colors.white,
                ),
              ),
            ),
            title: const Text(
              'Baby Growth Chart',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
          body: const TabBarView(
            children: [
              LengthChartView(),
              WeightChartView(),
            ],
          ),
        ),
      ),
    );
  }
}
