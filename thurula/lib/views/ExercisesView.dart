import 'package:flutter/material.dart';
import 'MenuView.dart';

class ExercisesView extends StatelessWidget {
  const ExercisesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Exercise Recommendations'),
            actions: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MenuView()));
                      })),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48.0),
              child: Container(
                color: const Color.fromARGB(255, 220, 104, 145),
                child: const TabBar(
                  isScrollable: true,
                  tabs : [
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
                )
              ),
              ),
            ),

          // add title to page
          body: TabBarView(
            children: [
              // First Trimester
              Column(
                children: [
                  // main title - month
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      // padding: EdgeInsets.all(20.0),
                      padding: EdgeInsets.only(left: 32.0, right: 32.0, top: 30.0, bottom: 10),
                      child: Text(
                        'Aug - Sep - Oct',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          color: const Color.fromARGB(255, 88, 119, 161),
                        ),
                      ),
                    ),
                  ),

                  // Exercise 1 card
                  Container(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0,),
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Image.asset(
                                    //   'assets/images/exercises/exercise1.jpg',
                                    //   height: 10,
                                    // ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        width: 80,
                                        height: 75,
                                        color: const Color.fromARGB(255, 220, 104, 145),
                                      ),
                                    ),

                                    Container(width: 5),
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          // exercise card 1
                                          children: <Widget>[
                                            Container(height: 5),
                                            const Padding(
                                              padding: EdgeInsets.only(left: 15, bottom: 5),
                                              // exercise title/name
                                              child: Text(
                                                "Diaphragmatic Breath",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Montserrat',
                                                  //   color #504E4E
                                                  color: const Color.fromARGB(255, 80, 78, 78),
                                                ),
                                              ),
                                            ),

                                            Container(height: 5),
                                            // exercise description
                                            const Padding(
                                              // padding: EdgeInsets.all(20.0),
                                              padding: EdgeInsets.only(left: 15),
                                              child: Text(
                                              "Stand with feet wide, knees soft, eyes closed and hands on belly. Take deep breaths into the belly allowing it to expand and contract fully.",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Montserrat',
                                                color: const Color.fromARGB(255, 131, 131, 131),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                    )
                                  ],
                                ),
                              )
                            ]
                        )
                    ),
                  ),

                  // Exercise 2 card
                  Container(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0, top:0),
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Image.asset(
                                    //   'assets/images/exercises/exercise1.jpg',
                                    //   height: 10,
                                    // ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        width: 80,
                                        height: 75,
                                        color: const Color.fromARGB(255, 220, 104, 145),
                                      ),
                                    ),

                                    Container(width: 5),
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          // exercise card 1
                                          children: <Widget>[
                                            Container(height: 5),
                                            const Padding(
                                              padding: EdgeInsets.only(left: 15, bottom: 5),
                                              // exercise title/name
                                              child: Text(
                                                "Standing Abs",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Montserrat',
                                                  //   color #504E4E
                                                  color: const Color.fromARGB(255, 80, 78, 78),
                                                ),
                                              ),
                                            ),

                                            Container(height: 5),
                                            // exercise description
                                            const Padding(
                                              // padding: EdgeInsets.all(20.0),
                                              padding: EdgeInsets.only(left: 15),
                                              child: Text(
                                                "Tap one toe straight forward, angling your hip bones up toward the ceiling and squeezing into your glutes while leaning back.",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Montserrat',
                                                  color: const Color.fromARGB(255, 131, 131, 131),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                    )
                                  ],
                                ),
                              )
                            ]
                        )
                    ),
                  ),

                  // Exercise 3 card
                  Container(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0,),
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Image.asset(
                                    //   'assets/images/exercises/exercise1.jpg',
                                    //   height: 10,
                                    // ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        width: 80,
                                        height: 75,
                                        color: const Color.fromARGB(255, 220, 104, 145),
                                      ),
                                    ),

                                    Container(width: 5),
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          // exercise card 1
                                          children: <Widget>[
                                            Container(height: 5),
                                            const Padding(
                                              padding: EdgeInsets.only(left: 15, bottom: 5),
                                              // exercise title/name
                                              child: Text(
                                                "P.sit to Stand",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Montserrat',
                                                  //   color #504E4E
                                                  color: const Color.fromARGB(255, 80, 78, 78),
                                                ),
                                              ),
                                            ),

                                            Container(height: 5),
                                            // exercise description
                                            const Padding(
                                              // padding: EdgeInsets.all(20.0),
                                              padding: EdgeInsets.only(left: 15),
                                              child: Text(
                                                "Stand tall with feet, knees, and thighs together and turn your palms forward.",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Montserrat',
                                                  color: const Color.fromARGB(255, 131, 131, 131),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                    )
                                  ],
                                ),
                              )
                            ]
                        )
                    ),
                  ),
                ],
              ),

              // Second Trimester
              Column(
                children: [
                  // main title - month
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      // padding: EdgeInsets.all(20.0),
                      padding: EdgeInsets.only(left: 32.0, right: 32.0, top: 30.0, bottom: 10.0),
                      child: Text(
                        'Nov - Dec - Jan',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          color: const Color.fromARGB(255, 88, 119, 161),
                        ),
                      ),
                    ),
                  ),

                  // Exercise 1 card
                  Container(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0,),
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Image.asset(
                                    //   'assets/images/exercises/exercise1.jpg',
                                    //   height: 10,
                                    // ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        width: 80,
                                        height: 75,
                                        color: const Color.fromARGB(255, 220, 104, 145),
                                      ),
                                    ),

                                    Container(width: 5),
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          // exercise card 1
                                          children: <Widget>[
                                            Container(height: 5),
                                            const Padding(
                                              padding: EdgeInsets.only(left: 15, bottom: 5),
                                              // exercise title/name
                                              child: Text(
                                                "Step Back",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Montserrat',
                                                  //   color #504E4E
                                                  color: const Color.fromARGB(255, 80, 78, 78),
                                                ),
                                              ),
                                            ),

                                            Container(height: 5),
                                            // exercise description
                                            const Padding(
                                              // padding: EdgeInsets.all(20.0),
                                              padding: EdgeInsets.only(left: 15),
                                              child: Text(
                                                "Step one foot back as if you are mid-step and lower your back heel down, leaning your body forward and arms reaching back behind you. ",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Montserrat',
                                                  color: const Color.fromARGB(255, 131, 131, 131),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                    )
                                  ],
                                ),
                              )
                            ]
                        )
                    ),
                  ),

                  // Exercise 2 card
                  Container(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0, top:0),
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Image.asset(
                                    //   'assets/images/exercises/exercise1.jpg',
                                    //   height: 10,
                                    // ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        width: 80,
                                        height: 75,
                                        color: const Color.fromARGB(255, 220, 104, 145),
                                      ),
                                    ),

                                    Container(width: 5),
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          // exercise card 1
                                          children: <Widget>[
                                            Container(height: 5),
                                            const Padding(
                                              padding: EdgeInsets.only(left: 15, bottom: 5),
                                              // exercise title/name
                                              child: Text(
                                                "Stagger Row",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Montserrat',
                                                  //   color #504E4E
                                                  color: const Color.fromARGB(255, 80, 78, 78),
                                                ),
                                              ),
                                            ),

                                            Container(height: 5),
                                            // exercise description
                                            const Padding(
                                              // padding: EdgeInsets.all(20.0),
                                              padding: EdgeInsets.only(left: 15),
                                              child: Text(
                                                "Holding onto light hand weights or water bottles, sit your hips back into a p.sit, hinging at your hips with both knees deeply bent and weights reaching on a low diagonal.",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Montserrat',
                                                  color: const Color.fromARGB(255, 131, 131, 131),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                    )
                                  ],
                                ),
                              )
                            ]
                        )
                    ),
                  ),

                  // Exercise 3 card
                  Container(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0,),
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Image.asset(
                                    //   'assets/images/exercises/exercise1.jpg',
                                    //   height: 10,
                                    // ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        width: 80,
                                        height: 75,
                                        color: const Color.fromARGB(255, 220, 104, 145),
                                      ),
                                    ),

                                    Container(width: 5),
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          // exercise card 1
                                          children: <Widget>[
                                            Container(height: 5),
                                            const Padding(
                                              padding: EdgeInsets.only(left: 15, bottom: 5),
                                              // exercise title/name
                                              child: Text(
                                                "Rotating Stagger",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Montserrat',
                                                  //   color #504E4E
                                                  color: const Color.fromARGB(255, 80, 78, 78),
                                                ),
                                              ),
                                            ),

                                            Container(height: 5),
                                            // exercise description
                                            const Padding(
                                              // padding: EdgeInsets.all(20.0),
                                              padding: EdgeInsets.only(left: 15),
                                              child: Text(
                                                "From your stagger position, keep your standing foot forward and pivot your hips and torso toward your front leg, rotating on a 45-degree angle out to the side.",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Montserrat',
                                                  color: const Color.fromARGB(255, 131, 131, 131),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                    )
                                  ],
                                ),
                              )
                            ]
                        )
                    ),
                  ),
                ],
              ),

              // Third Trimester
              Column(
                children: [
                  // main title - month
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      // padding: EdgeInsets.all(20.0),
                      padding: EdgeInsets.only(left: 32.0, right: 32.0, top: 30.0, bottom: 10.0),
                      child: Text(
                        'Feb - Mar - Apr',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          color: const Color.fromARGB(255, 88, 119, 161),
                        ),
                      ),
                    ),
                  ),

                  // Exercise 1 card
                  Container(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0,),
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Image.asset(
                                    //   'assets/images/exercises/exercise1.jpg',
                                    //   height: 10,
                                    // ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        width: 80,
                                        height: 75,
                                        color: const Color.fromARGB(255, 220, 104, 145),
                                      ),
                                    ),

                                    Container(width: 5),
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          // exercise card 1
                                          children: <Widget>[
                                            Container(height: 5),
                                            const Padding(
                                              padding: EdgeInsets.only(left: 15, bottom: 5),
                                              // exercise title/name
                                              child: Text(
                                                "Diaphragmatic Breath",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Montserrat',
                                                  //   color #504E4E
                                                  color: const Color.fromARGB(255, 80, 78, 78),
                                                ),
                                              ),
                                            ),

                                            Container(height: 5),
                                            // exercise description
                                            const Padding(
                                              // padding: EdgeInsets.all(20.0),
                                              padding: EdgeInsets.only(left: 15),
                                              child: Text(
                                                "Stand with feet wide, knees soft, eyes closed and hands on belly. Take deep breaths into the belly allowing it to expand and contract fully.",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Montserrat',
                                                  color: const Color.fromARGB(255, 131, 131, 131),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                    )
                                  ],
                                ),
                              )
                            ]
                        )
                    ),
                  ),

                  // Exercise 2 card
                  Container(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0, top:0),
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Image.asset(
                                    //   'assets/images/exercises/exercise1.jpg',
                                    //   height: 10,
                                    // ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        width: 80,
                                        height: 75,
                                        color: const Color.fromARGB(255, 220, 104, 145),
                                      ),
                                    ),

                                    Container(width: 5),
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          // exercise card 1
                                          children: <Widget>[
                                            Container(height: 5),
                                            const Padding(
                                              padding: EdgeInsets.only(left: 15, bottom: 5),
                                              // exercise title/name
                                              child: Text(
                                                "Standing Abs",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Montserrat',
                                                  //   color #504E4E
                                                  color: const Color.fromARGB(255, 80, 78, 78),
                                                ),
                                              ),
                                            ),

                                            Container(height: 5),
                                            // exercise description
                                            const Padding(
                                              // padding: EdgeInsets.all(20.0),
                                              padding: EdgeInsets.only(left: 15),
                                              child: Text(
                                                "Tap one toe straight forward, angling your hip bones up toward the ceiling and squeezing into your glutes while leaning back.",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Montserrat',
                                                  color: const Color.fromARGB(255, 131, 131, 131),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                    )
                                  ],
                                ),
                              )
                            ]
                        )
                    ),
                  ),

                  // Exercise 3 card
                  Container(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0,),
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Image.asset(
                                    //   'assets/images/exercises/exercise1.jpg',
                                    //   height: 10,
                                    // ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        width: 80,
                                        height: 75,
                                        color: const Color.fromARGB(255, 220, 104, 145),
                                      ),
                                    ),

                                    Container(width: 5),
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          // exercise card 1
                                          children: <Widget>[
                                            Container(height: 5),
                                            const Padding(
                                              padding: EdgeInsets.only(left: 15, bottom: 5),
                                              // exercise title/name
                                              child: Text(
                                                "P.sit to Stand",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Montserrat',
                                                  //   color #504E4E
                                                  color: const Color.fromARGB(255, 80, 78, 78),
                                                ),
                                              ),
                                            ),

                                            Container(height: 5),
                                            // exercise description
                                            const Padding(
                                              // padding: EdgeInsets.all(20.0),
                                              padding: EdgeInsets.only(left: 15),
                                              child: Text(
                                                "Stand tall with feet, knees, and thighs together and turn your palms forward.",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Montserrat',
                                                  color: const Color.fromARGB(255, 131, 131, 131),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                    )
                                  ],
                                ),
                              )
                            ]
                        )
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}