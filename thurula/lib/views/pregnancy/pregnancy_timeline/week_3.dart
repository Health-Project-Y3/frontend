import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';

class Week3View extends StatelessWidget {
  const Week3View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 227, 227),
      body: Column(
        children: [
          const Center(
              child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text("First trimester -  Week 3",
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
                  child: Image.asset('assets/images/fetus-size/3.jpg',
                      height: 100),
                ),
              ),
              const Expanded(
                child: Text(
                  'You ovulated this week, and the moment you’ve been waiting for has finally arrived: You’ve conceived!\nMeaning your soon-to-be-fetus has started on its miraculous transformation from solitary cell to bouncing baby boy or girl.',
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
              "During week three of pregnancy, the fertilized egg implants into the uterine lining. Some people experience mild abdominal cramping or light spotting known as 'implantation bleeding.'\nCall a health care provider if you're bleeding heavily or have intense pain; this could indicate an ectopic pregnancy where the embryo implanted outside of the uterus (usually in the fallopian tube).",
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
                  "Up your iron and vitamin C.",
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
                  "Choose calcium-rich foods.",
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
                  "Get plenty of protein.",
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
