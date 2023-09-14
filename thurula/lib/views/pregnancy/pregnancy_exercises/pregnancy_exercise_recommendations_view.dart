import 'package:flutter/material.dart';
import '../../menu_view.dart';
import 'package:thurula/views/pregnancy/pregnancy_exercises/pregnancy_exercise_timer_view.dart';

// first trimester exercises
List<String> exerciseNamesT1 = [
  "Diaphragmatic Breath with Pelvic Floor Activation",
  "P.sit to Stand",
  "Standing Abs",
  "Pelvis Articulation",
  "Butt Press"
];

// second trimester exercises
List<String> exerciseNamesT2 = [
  "Step Back",
  "Stagger Row",
  "Rotating Stagger",
  "Internal 45 with Side Stretch",
  "Leg Lift"
];

// third trimester exercises
List<String> exerciseNamesT3 = [
  "Fire Hydrant",
  "Kneeling Hip Flexor Stretch",
  "Intercoastal Kneeling Stretch",
  "Hamstring Press",
  "Bridge"
];

class ExercisesView extends StatelessWidget {
  const ExercisesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MenuView()));
              },
            ),
            backgroundColor: const Color.fromARGB(255, 220, 104, 145),
            // back button

            title: const Text(
              'Exercises',
            ),

            // actions
            actions: [
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () {
                //   direct to exercise history page
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const ExercisesView())
                //   );
                },
              ),
            ],

            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48.0),
              child: Container(
                  color: const Color.fromARGB(255, 220, 104, 145),
                  child: const TabBar(
                    indicatorColor: Colors.white,
                    isScrollable: true,
                    tabs: [
                      Tab(
                        text: "First Trimester",
                      ),
                      Tab(
                        text: "Second Trimester",
                      ),
                      Tab(
                        text: "Third Trimester",
                      )
                    ],
                  )),
            ),
          ),

          // add title to page
          body: TabBarView(
            children: [
              // First Trimester
              SingleChildScrollView(
                child: Column(
                  children: [
                    // padding
                    Padding(
                      padding: const EdgeInsets.only(right: 30, top: 20),
                      // calories and time
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              // show congratulations alert
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                  //   alert dialog with an image and text
                                    return AlertDialog(
                                      title: const Text(
                                        // center align
                                        textAlign: TextAlign.center,
                                        "You have worked out for 15 minutes today... \nGood job!",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Inter',
                                          color: Color.fromARGB(255, 220, 104, 145),
                                        ),
                                      ),
                                      content: Image.asset(
                                        'assets/images/icons/trophy.jpg',
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            "OK",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Inter',
                                              //   color #504E4E
                                              color: Color.fromARGB(
                                                  255, 80, 78, 78),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: const Image(
                              image: AssetImage(
                                  'assets/images/icons/crown.png'),
                              width: 25,
                            ),
                          ),
                          Container(width: 150),
                          Image.asset(
                            'assets/images/icons/calories.png',
                            height: 20,
                            width: 20
                          ),
                          const Text(
                            " 55 kcal",
                            style: TextStyle(
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                              //   color #878787
                              color: Color.fromARGB(255, 131, 131, 131),
                            ),
                          ),

                        //   time
                          Container(width: 20),
                          Image.asset(
                            'assets/images/icons/clock.png',
                            height: 20,
                            width: 20
                          ),
                          const Text(
                            " 10 min",
                            style: TextStyle(
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                              //   color #878787
                              color: Color.fromARGB(255, 131, 131, 131),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Exercise 1 card
                    for(int x = 1; x<=5; x++)...[
                      Container(height: 10),
                      Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20.0,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      ExerciseTimerView(exercise: '1, $x')));
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Colors.white, // Color of the card
                              elevation: 2, // Card elevation
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.center,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: Image.asset(
                                        'assets/images/exercises/firstm$x.png',
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(width: 5),
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,

                                        // exercise card
                                        children: <Widget>[
                                          Container(height: 5),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(left: 15, bottom: 5),
                                            // exercise title/name
                                            child: Text(
                                              exerciseNamesT1[x-1],
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Inter',
                                                //   color #504E4E
                                                color: Color.fromARGB(
                                                    255, 80, 78, 78),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ))
                                ],
                              ),
                            ),
                          )),

                    ],
                      // disclaimer
                      const Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Disclaimer: it's important to consult with your obstetric provider who may recommend modifications to your exercise routine.",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Inter',
                            color: Color.fromARGB(
                                255, 131, 131, 131),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Second Trimester
              SingleChildScrollView(
                child: Column(
                  children: [
                    // padding
                    Padding(
                      padding: const EdgeInsets.only(right: 30, top: 20),
                      // calories and time
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Image.asset(
                              'assets/images/icons/crown.png',
                              width: 25
                          ),
                          Container(width: 140),
                          Image.asset(
                              'assets/images/icons/calories.png',
                              height: 20,
                              width: 20
                          ),
                          const Text(
                            " 55 kcal",
                            style: TextStyle(
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                              //   color #878787
                              color: Color.fromARGB(255, 131, 131, 131),
                            ),
                          ),

                          //   time
                          Container(width: 20),
                          Image.asset(
                              'assets/images/icons/clock.png',
                              height: 20,
                              width: 20
                          ),
                          const Text(
                            " 10 min",
                            style: TextStyle(
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                              //   color #878787
                              color: Color.fromARGB(255, 131, 131, 131),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Exercise 1 card
                    for(int x = 1; x<=5;x++)...[
                      Container(height: 10),
                      Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20.0,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      ExerciseTimerView(exercise: '2, $x')));
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Colors.white, // Color of the card
                              elevation: 2, // Card elevation
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.center,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: Image.asset(
                                        'assets/images/exercises/secondm$x.png',
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(width: 5),
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,

                                        // exercise card
                                        children: <Widget>[
                                          Container(height: 5),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(left: 15, bottom: 5),
                                            // exercise title/name
                                            child: Text(
                                              exerciseNamesT2[x-1],
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Inter',
                                                //   color #504E4E
                                                color: Color.fromARGB(
                                                    255, 80, 78, 78),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          )),
                    ],
                      // disclaimer
                      const Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Disclaimer: it's important to consult with your obstetric provider who may recommend modifications to your exercise routine.",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Inter',
                            color: Color.fromARGB(
                                255, 131, 131, 131),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Third Trimester
              SingleChildScrollView(
                child: Column(
                  children: [
                    // padding
                    Padding(
                      padding: const EdgeInsets.only(right: 30, top: 20),
                      // calories and time
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Image.asset(
                              'assets/images/icons/crown.png',
                              width: 25
                          ),
                          Container(width: 140),
                          Image.asset(
                              'assets/images/icons/calories.png',
                              height: 20,
                              width: 20
                          ),
                          const Text(
                            " 55 kcal",
                            style: TextStyle(
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                              //   color #878787
                              color: Color.fromARGB(255, 131, 131, 131),
                            ),
                          ),

                          //   time
                          Container(width: 20),
                          Image.asset(
                              'assets/images/icons/clock.png',
                              height: 20,
                              width: 20
                          ),
                          const Text(
                            " 10 min",
                            style: TextStyle(
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                              //   color #878787
                              color: Color.fromARGB(255, 131, 131, 131),
                            ),
                          ),

                        //   button to start workout

                        ],
                      ),
                    ),

                    // Exercise 1 card
                    for(int x = 1; x<=5;x++)...[
                      Container(height: 10),
                      Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20.0,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      ExerciseTimerView(exercise: '3, $x')));
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Colors.white, // Color of the card
                              elevation: 2, // Card elevation
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.center,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: Image.asset(
                                        'assets/images/exercises/thirdm$x.png',
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(width: 5),
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,

                                        // exercise card 1
                                        children: <Widget>[
                                          Container(height: 5),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(left: 15, bottom: 5),
                                            // exercise title/name
                                            child: Text(
                                              exerciseNamesT3[x-1],
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Inter',
                                                //   color #504E4E
                                                color: Color.fromARGB(
                                                    255, 80, 78, 78),
                                              ),
                                            ),
                                          ),

                                          // // exercise description
                                          // const Padding(
                                          //   // padding: EdgeInsets.all(20.0),
                                          //   padding: EdgeInsets.only(left: 15),
                                          //   child: Text(
                                          //     "45 seconds",
                                          //     style: TextStyle(
                                          //       fontSize: 17,
                                          //       fontFamily: 'Inter',
                                          //       color: Color.fromARGB(
                                          //           255, 131, 131, 131),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          )),
                    ],
                    // disclaimer
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Disclaimer: it's important to consult with your obstetric provider who may recommend modifications to your exercise routine.",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Inter',
                          color: Color.fromARGB(
                              255, 131, 131, 131),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

