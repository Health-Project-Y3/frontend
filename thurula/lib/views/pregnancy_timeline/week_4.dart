import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';

class Week4View extends StatelessWidget {
  const Week4View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 227, 227),
      body: Column(
        children: [
          const Center(
              child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text("First trimester - Week 4",
                style: TextStyle(
                  color: Color.fromARGB(255, 220, 104, 145),
                  fontFamily: 'Inter',
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                )),
          )),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Your Baby’s Development',
                style: TextStyle(
                  color: Color.fromARGB(255, 88, 119, 161),
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(
                    10.0), // change this to the desired amount of padding
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(80.0),
                  child: Image.asset('assets/images/fetus-size/4.jpg',
                      height: 100),
                ),
              ),
              const Expanded(
                child: Text(
                  'Your itty bitty embryo has two layers of cells called the epiblast and the hypoblast.\nSoon they’ll develop into all of your baby’s body parts and systems.',
                  style: TextStyle(
                    color: Color.fromARGB(255, 88, 119, 161),
                    fontSize: 14.0,
                    height: 1.5,
                  ), // change this to the desired text color
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 13.0, 20.0, 0.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Your Body',
                style: TextStyle(
                  color: Color.fromARGB(255, 88, 119, 161),
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(
                20.0), // change this to the desired amount of padding
            child: Text(
              "Breast tenderness, one of the earliest signs of pregnancy in some people, might make your bra feel extra uncomfortable at this time.\nSome also experience a heightened sense of smell or taste, fatigue, constipation, bloating, and mood swings. But don't worry if you don't have any pregnancy symptoms at all; they might take a few extra weeks to show up.",
              style: TextStyle(
                color: Color.fromARGB(255, 88, 119, 161),
                fontSize: 14.0,
                height: 1.5,
              ), // change this to the desired text color
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 13.0, 20.0, 0.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Tips for You This Week',
                style: TextStyle(
                  color: Color.fromARGB(255, 88, 119, 161),
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
                child: Text(
                  "Make a prenatal appointment.",
                  style: TextStyle(
                    color: Color.fromARGB(255, 88, 119, 161),
                    fontSize: 14.0,
                    height: 1.5,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
                child: Text(
                  "Don't forget vitamin D.",
                  style: TextStyle(
                    color: Color.fromARGB(255, 88, 119, 161),
                    fontSize: 14.0,
                    height: 1.5,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
                child: Text(
                  "Avoid secondhand smoke.",
                  style: TextStyle(
                    color: Color.fromARGB(255, 88, 119, 161),
                    fontSize: 14.0,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
