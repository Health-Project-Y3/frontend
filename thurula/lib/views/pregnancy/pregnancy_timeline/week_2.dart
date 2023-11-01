import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';

class Week2View extends StatelessWidget {
  const Week2View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // #f7f7f7
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const Center(
              child: Padding(
            padding: EdgeInsets.only(
                left: 20.0, right: 20.0, top: 20.0, bottom: 0.0),
            child: Text("First trimester - Week 2",
                style: TextStyle(
                  color: Color.fromARGB(255, 220, 104, 145),
                  fontFamily: 'Inter',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
          )),
          Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15.0, bottom: 5),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 15, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            // bullet point
                            Icon(
                              Icons.rectangle_rounded,
                              size: 20,
                              color: Color.fromARGB(255, 88, 119, 161),
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Your Baby\'s Development',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 88, 119, 161),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            //   wrapped text
                            const Expanded(
                              child: Text(
                                'Surprise! You are not actually pregnant during your first week of pregnancy! Your due date is calculated from the first day of your last period.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  height: 1.5,
                                ),
                              ),
                            ),
                            // bullet point
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Image.asset(
                                    'assets/images/fetus-size/2.jpg',
                                    height: 100),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))),

          // Your body
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 0),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0.5,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 15, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // bullet point
                          Icon(
                            Icons.rectangle_rounded,
                            size: 20,
                            color: Color.fromARGB(255, 88, 119, 161),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Your Body',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 88, 119, 161),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Ovulation typically occurs during what's considered week two. Your ovary will release a mature egg that travels into the fallopian tube, where it awaits fertilization with sperm.\nSymptoms of ovulation can include twinging lower abdominal pain (mittelschmerz), breast tenderness, slippery discharge that resembles egg whites, and increased basal body temperature.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                )),
          ),

          // Weekly tips
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 5, bottom: 0),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0.5,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 15, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'TIPS FOR YOU THIS WEEK',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 220, 104, 145),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          // bullet point
                          Icon(
                            Icons.tips_and_updates,
                            size: 22,
                            color: Color.fromARGB(255, 220, 104, 145),
                          ),
                          SizedBox.square(
                            dimension: 10,
                          ),
                          //   wrapped text
                          Text(
                            "Fill up on folic acid.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          // bullet point
                          Icon(
                            Icons.tips_and_updates,
                            size: 22,
                            color: Color.fromARGB(255, 220, 104, 145),
                          ),
                          SizedBox.square(
                            dimension: 10,
                          ),
                          //   wrapped text
                          Text(
                            "Spot early pregnancy signs.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          // bullet point
                          Icon(
                            Icons.tips_and_updates,
                            size: 22,
                            color: Color.fromARGB(255, 220, 104, 145),
                          ),
                          SizedBox.square(
                            dimension: 10,
                          ),
                          //   wrapped text
                          Text(
                            "Shop for pregnancy tests.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ),
        ],
      )),
    );
  }
}
