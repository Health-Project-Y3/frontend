import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';

class Week21View extends StatelessWidget {
  const Week21View({super.key});

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
            child: Text("Second Trimester - Week 21",
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
                                "Your baby's arms and legs are in proportion this week and his movements are now much more coordinated. Also, notice a jump in baby's length this week? Up until now, we've been measuring from crown to rump, but now we start to measure from crown to heel, which explains why he suddenly grew so much.",
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
                                    'assets/images/fetus-size/21.jpg',
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
                        "Although you might've had round ligament pain for a while, it tends to increase as the baby grows. You may feel sharpness in your hip, groin, and abdomen as they stretch to accommodate your growing uterus.",
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
                            "Avoid unsafe activities.",
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
                            "Put your feet up.",
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
                            "Go for a swim.",
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
