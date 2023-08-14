import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';

class Week2View extends StatelessWidget {
  const Week2View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 227, 227),
      body: Column(
        children: [
          const Center(
              child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text("First trimester - Week 2",
                style: TextStyle(
                  color: Color.fromARGB(255, 220, 104, 145),
                  fontFamily: 'Montserrat',
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
                  fontFamily: 'Montserrat',
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
                  child: Image.asset('assets/images/fetus-size/2.jpg',
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
                  fontFamily: 'Montserrat',
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
              "Ovulation typically occurs during what's considered week two. Your ovary will release a mature egg that travels into the fallopian tube, where it awaits fertilization with sperm.\nSymptoms of ovulation can include twinging lower abdominal pain (mittelschmerz), breast tenderness, slippery discharge that resembles egg whites, and increased basal body temperature.",
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
                  fontFamily: 'Montserrat',
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
