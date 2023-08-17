import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';

class Week1View extends StatelessWidget {
  const Week1View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 227, 227),
      body: Column(
        children: [
          const Center(
              child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text("First trimester - Week 1",
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
                  child: Image.asset('assets/images/fetus-size/1.jpg',
                      height: 100),
                ),
              ),
              const Expanded(
                child: Text(
                  'Surprise! You are not actually pregnant during your first week of pregnancy! Your due date is calculated from the first day of your last period.',
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
              "Since doctors calculate your due date from the first day of your last menstrual period, week one begins with the start of the last period you have before you conceive. That's to say that you're not technically pregnant yet.\nYou can, however, expect to experience your typical menstrual symptoms including bleeding, cramping, sore breasts, mood swings, etc.",
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
                  "Fill up on folic acid.",
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
                  "Spot early pregnancy signs.",
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
                  "Shop for pregnancy tests.",
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
