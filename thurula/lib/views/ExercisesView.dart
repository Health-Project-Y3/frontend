import 'package:flutter/material.dart';
import 'MenuView.dart';
import 'package:thurula/views/ExerciseTimerView.dart';

class ExercisesView extends StatelessWidget {
  const ExercisesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 220, 104, 145),
            title: const Text(
                'Exercise Recommendations',
            ),
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
                child: TabBar(
                  // text color of indicator pink
                  labelColor: const Color.fromARGB(255, 220, 104, 145),
                  // text color of non-selected tabs
                  unselectedLabelColor: Colors.white,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: const Color.fromARGB(255, 250, 238, 244),
                  ),
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
                  isScrollable: true,
                  tabs : const [
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
                          fontFamily: 'Inter',
                          color: const Color.fromARGB(255, 88, 119, 161),
                        ),
                      ),
                    ),
                  ),

                  // Exercise 1 card
                  Container(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0,),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ExerciseTimerView()));
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
                                            fontFamily: 'Inter',
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
                                          "Stand with feet wide, knees soft, eyes closed and hands on belly.",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            color: const Color.fromARGB(255, 131, 131, 131),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              )
                            ],
                          ),
                        ),
                      )
                  ),

                  // Exercise 2 card
                  Container(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0, top:0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ExerciseTimerView()));
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
                                          fontFamily: 'Inter',
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
                                        "Stand with feet wide, knees soft, eyes closed and hands on belly.",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          color: const Color.fromARGB(255, 131, 131, 131),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            )
                          ],
                        ),
                      ),
                      )
                  ),

                  // Exercise 3 card
                  Container(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0,),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ExerciseTimerView()));
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
                                            fontFamily: 'Inter',
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
                                          "Stand with feet wide, knees soft, eyes closed and hands on belly.",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            color: const Color.fromARGB(255, 131, 131, 131),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              )
                            ],
                          ),
                        ),
                      )
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
                          fontFamily: 'Inter',
                          color: const Color.fromARGB(255, 88, 119, 161),
                        ),
                      ),
                    ),
                  ),

                  // Exercise 1 card
                  Container(height: 10),
                  Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0,),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ExerciseTimerView()));
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
                                            fontFamily: 'Inter',
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
                                          "Stand with feet wide, knees soft, eyes closed and hands on belly.",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            color: const Color.fromARGB(255, 131, 131, 131),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              )
                            ],
                          ),
                        ),
                      )
                  ),

                  // Exercise 2 card
                  Container(height: 10),
                  Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top:0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ExerciseTimerView()));
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
                                            fontFamily: 'Inter',
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
                                          "Stand with feet wide, knees soft, eyes closed and hands on belly.",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            color: const Color.fromARGB(255, 131, 131, 131),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              )
                            ],
                          ),
                        ),
                      )
                  ),

                  // Exercise 3 card
                  Container(height: 10),
                  Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0,),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ExerciseTimerView()));
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
                                            fontFamily: 'Inter',
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
                                          "Stand with feet wide, knees soft, eyes closed and hands on belly.",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            color: const Color.fromARGB(255, 131, 131, 131),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              )
                            ],
                          ),
                        ),
                      )
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
                          fontFamily: 'Inter',
                          color: const Color.fromARGB(255, 88, 119, 161),
                        ),
                      ),
                    ),
                  ),

                  // Exercise 1 card
                  Container(height: 10),
                  Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0,),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ExerciseTimerView()));
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
                                            fontFamily: 'Inter',
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
                                          "Stand with feet wide, knees soft, eyes closed and hands on belly.",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            color: const Color.fromARGB(255, 131, 131, 131),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              )
                            ],
                          ),
                        ),
                      )
                  ),

                  // Exercise 2 card
                  Container(height: 10),
                  Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top:0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ExerciseTimerView()));
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
                                            fontFamily: 'Inter',
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
                                          "Stand with feet wide, knees soft, eyes closed and hands on belly.",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            color: const Color.fromARGB(255, 131, 131, 131),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              )
                            ],
                          ),
                        ),
                      )
                  ),

                  // Exercise 3 card
                  Container(height: 10),
                  Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0,),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ExerciseTimerView()));
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
                                            fontFamily: 'Inter',
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
                                          "Stand with feet wide, knees soft, eyes closed and hands on belly.",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Inter',
                                            color: const Color.fromARGB(255, 131, 131, 131),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              )
                            ],
                          ),
                        ),
                      )
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