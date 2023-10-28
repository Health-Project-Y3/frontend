import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';

class Week11View extends StatelessWidget {
  const Week11View({super.key});

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
            child: Text("First Trimester - Week 11",
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
                                'Your baby-to-be’s ears have migrated closer to their final destination on either side of his cute little head.our little one\'s fingers and toes are separating and looking like real baby parts. Fingernail and toenail beds are also beginning to develop.',
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
                                    'assets/images/fetus-size/11.jpg',
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
                        "Your growing baby bump might cause aches and cramping around your abdomen. This round ligament pain can be mildly uncomfortable or downright painful.",
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
                            "Eat calcium-rich foods.",
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
                            "Take care of your skin.",
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
                            "Build your support network.",
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
