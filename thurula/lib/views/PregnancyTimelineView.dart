import 'package:flutter/material.dart';

class PregnancyTimelineView extends StatelessWidget {
  const PregnancyTimelineView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48.0), // height of  TabBar
              child: Container(
                color: const Color.fromARGB(255, 220, 104, 145),
                child: const TabBar(
                  tabs: [
                    Tab(
                      text: "Week 1",
                    ),
                    Tab(
                      text: "Week 2",
                    ),
                    Tab(
                      text: "Week 3",
                    ),
                    Tab(
                      text: "Week 4",
                    )
                  ],
                ),
              ),
            ),
            title: const Text('Pregnancy Timeline'),
          ),
          body: TabBarView(
            children: [
              Column(
                children: [
                  const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text("First trimester",
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
              // Week 2
              Column(
                children: [
                  const Center(
                      child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text("First trimester",
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
              // Week 3
              Column(
                children: [
                  const Center(
                      child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text("First trimester",
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
              // Week 4
              Column(
                children: [
                  const Center(
                      child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text("First trimester",
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
            ],
          ),
        ),
      ),
    );
  }
}
