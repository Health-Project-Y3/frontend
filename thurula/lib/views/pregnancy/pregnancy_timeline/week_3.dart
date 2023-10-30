import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';

class Week3View extends StatelessWidget {
  const Week3View({super.key});

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
            child: Text("First Trimester - Week 3",
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
                                'You ovulated this week, and the moment you’ve been waiting for has finally arrived: You’ve conceived!\nMeaning your soon-to-be-fetus has started on its miraculous transformation from solitary cell to bouncing baby boy or girl.',
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
                                    'assets/images/fetus-size/3.jpg',
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
                        "During week three of pregnancy, the fertilized egg implants into the uterine lining. Some people experience mild abdominal cramping or light spotting known as 'implantation bleeding.'\nCall a health care provider if you're bleeding heavily or have intense pain; this could indicate an ectopic pregnancy where the embryo implanted outside of the uterus (usually in the fallopian tube).",
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
                            "Up your iron and vitamin C.",
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
                            "Choose calcium-rich foods.",
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
                            "Get plenty of protein.",
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
