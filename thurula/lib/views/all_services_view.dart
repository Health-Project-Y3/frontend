import 'package:flutter/material.dart';
import 'widgets/pregnancy_navbar_widget.dart';

void main() {
  runApp(AllServices());
}

class AllServices extends StatelessWidget {
  final List<String> imageNamesPregnancy = [
    'forum2.png',
    'timeline2.png',
    'monitor2.png',
    'vaccine2.png',
    'exercise2.png',
    'names2.png'
  ];

  final List<String> titlesPregnancy = [
    'Forum',
    'Timeline',
    'Health',
    'Vaccines',
    'Exercises',
    'Baby Names'
  ];

  final List<String> imageNamesChildcare = [
    'growth.png',
    'vaccine.png',
    'nap.png',
    'diaper.png',
    'feeding.png',
    'checklist.png',
    'vision.png',
  ];

  final List<String> titlesChildcare = [
    'Growth',
    'Vaccines',
    'Nap Timer',
    'Diaper Change',
    'Meal Tracker',
    'Checklist',
    'Vision Tests'
  ];

  AllServices({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 247, 247),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 220, 104, 145),
          title: const Text('All Services'),
        ),
        body: TilePage(imageNamesPregnancy: imageNamesPregnancy, titlesPregnancy: titlesPregnancy, imageNamesChildcare: imageNamesChildcare, titlesChildcare: titlesChildcare),
        bottomNavigationBar: const CreatePregnancyBottomNavigationBar(pageIndex: 2),
      ),
    );
  }
}

class TilePage extends StatelessWidget {
  final List<String> imageNamesPregnancy;
  final List<String> titlesPregnancy;
  final List<String> imageNamesChildcare;
  final List<String> titlesChildcare;

  const TilePage({super.key, required this.imageNamesPregnancy, required this.titlesPregnancy, required this.imageNamesChildcare, required this.titlesChildcare});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: imageNamesPregnancy.length + imageNamesChildcare.length,
      itemBuilder: (context, index) {
        if (index < imageNamesPregnancy.length) {
          if (index % 3 == 0 ) {
          return Row(
            children: [
              buildPregnancyTile(index),
              buildPregnancyTile(index + 1),
              buildPregnancyTile(index + 2),
            ],
          );
          } else {
            return const SizedBox(); // Empty SizedBox for the remaining items in the row
          }
          // Create a new row for every 3 tiles
        } else {
          if (index % 3 == 0) {
            // Create a new row for every 3 tiles
            return Row(
              children: [
                buildChildcareTile(index - imageNamesPregnancy.length),
                buildChildcareTile(index - imageNamesPregnancy.length + 1),
                buildChildcareTile(index - imageNamesPregnancy.length + 2),
              ],
            );
        } else {
          return const SizedBox(); // Empty SizedBox for the remaining items in the row
        }
        }
      }
    );
  }

  Widget buildPregnancyTile(int index) {
    if (index >= imageNamesPregnancy.length) {
      // Check if the index is out of bounds
      return const SizedBox();
    }

    return InkResponse(
      onTap: () {
        // Navigate to the forum screen here
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.all(7.0),
        width: 110,
        height: 120,
        decoration: BoxDecoration(
          // color: const Color.fromARGB(255, 250, 238, 244),
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              child: Image.asset(
                'assets/images/menu-tiles/${imageNamesPregnancy[index]}',
                height: 80,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              titlesPregnancy[index],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color.fromARGB(255, 88, 119, 161),
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildChildcareTile(int index) {
    if (index >= imageNamesChildcare.length) {
      // Check if the index is out of bounds
      return const SizedBox();
    }

    return InkResponse(
      onTap: () {
        // Navigate to the forum screen here
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.all(7.0),
        width: 110,
        height: 120,
        decoration: BoxDecoration(
          // color: const Color.fromARGB(255, 250, 238, 244),
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              child: Image.asset(
                'assets/images/menu-tiles/${imageNamesChildcare[index]}',
                height: 80,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              titlesChildcare[index],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color.fromARGB(255, 220, 104, 145),
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
