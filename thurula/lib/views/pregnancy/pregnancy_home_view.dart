import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thurula/models/vaccination_model.dart';
import 'package:thurula/services/local_service.dart';
import 'package:thurula/services/vaccination_service.dart';
import 'package:thurula/views/forum/forum_home_view.dart';

// import 'package:thurula/views/login_view.dart';
import 'package:thurula/views/pregnancy/mother_health_tracker.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline_view.dart';
import 'package:thurula/views/pregnancy/pregnancy_exercises/pregnancy_exercise_recommendations_view.dart';
import 'package:thurula/views/pregnancy/pregnancy_baby_names_view.dart';
import 'package:thurula/views/pregnancy/vaccination_tracker_view.dart';

import '../../providers/user_provider.dart';
import '../widgets/navbar_widget.dart';

class PregnancyHomeView extends StatefulWidget {
  const PregnancyHomeView({super.key});

  @override
  _PregnancyHomeViewState createState() => _PregnancyHomeViewState();
}

class _PregnancyHomeViewState extends State<PregnancyHomeView> {
  int week = 0;
  int remDays = 0;
  int upcomingVaccineDate = 1;

  @override
  void initState() {
    super.initState();
    fetchWeekAndDays();
  }

  Future<void> fetchWeekAndDays() async {
    week = CalculateCurrentWeek(context) + 1;
    remDays = CalculateDays(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(height: 15),
            Text(
              'Welcome, ${context.read<UserProvider>().user?.fname ?? ''}!',
              style: const TextStyle(
                color: Color.fromARGB(255, 220, 104, 145),
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // menu tiles
            SizedBox(
              height: 120,
              width: MediaQuery.of(context).size.width, // Set the width
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  //Forum
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkResponse(
                      onTap: () {
                        // Navigate to the forum screen here
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForumHomeView(),
                          ),
                        );
                      },
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0.5,
                              blurRadius: 2,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 5),
                            Image.asset(
                              'assets/images/menu-tiles/forum2.png',
                              height: 70,
                            ),
                            const SizedBox(height: 7),
                            const Text(
                              'Forum',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 88, 119, 161),
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Pregnancy Timeline
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkResponse(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PregnancyTimelineView(),
                            ),
                          );
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.5,
                                blurRadius: 2,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 5),
                              Image.asset(
                                  'assets/images/menu-tiles/timeline2.png',
                                  height: 70),
                              // ),
                              const SizedBox(height: 7),
                              const Text(
                                'Timeline',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 88, 119, 161),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      )),

                  // Health Monitoring
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkResponse(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MotherHealthTracker(),
                            ),
                          );
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.5,
                                blurRadius: 2,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 5),
                              Image.asset(
                                  'assets/images/menu-tiles/monitor2.png',
                                  height: 70),
                              // ),
                              const SizedBox(height: 7),
                              const Text(
                                'Health',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 88, 119, 161),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      )),

                  // Vaccination Tracking
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkResponse(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const MomVaccinationTrackerView(),
                            ),
                          );
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.5,
                                blurRadius: 3,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 5),
                              Image.asset(
                                  'assets/images/menu-tiles/vaccine2.png',
                                  height: 70),
                              // ),
                              const SizedBox(height: 7),
                              const Text(
                                'Vaccines',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 88, 119, 161),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      )),

                  // Exercise Recommendations
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkResponse(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PregnancyExercisesView(),
                            ),
                          );
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.5,
                                blurRadius: 3,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 5),
                              Image.asset(
                                  'assets/images/menu-tiles/exercise2.png',
                                  height: 70),
                              // ),
                              const SizedBox(height: 7),
                              const Text(
                                'Exercises',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 88, 119, 161),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      )),

                  // Baby Name Suggestions
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkResponse(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BabyNames(),
                            ),
                          );
                        },
                        child: Container(
                          width: 100,
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.5,
                                blurRadius: 3,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 5),
                              Image.asset('assets/images/menu-tiles/names2.png',
                                  height: 70),
                              // ),
                              const SizedBox(height: 7),
                              const Text(
                                'Baby Names',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 88, 119, 161),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),

            // days left
            Container(
              width: 400,
              height: 170,
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
              child: Center(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Column(
                    children: [
                      Padding(
                        // padding top
                        padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                        child: Image.asset(
                          'assets/images/pregnancy-home/countdown1.jpg',
                          height: 120,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          "$remDays days left for your bundle of joy to arrive!",
                          style: const TextStyle(
                            color: Color.fromARGB(255, 88, 119, 161),
                            fontSize: 18.0,
                            fontFamily: 'Inter',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 5),

            // baby size
            IntrinsicHeight(
              child: Container(
                width: 400,
                // height: 200,
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
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // bullet point
                          const Icon(
                            Icons.square,
                            size: 10,
                            color: Color.fromARGB(255, 88, 119, 161),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Week $week",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 88, 119, 161),
                            ),
                          ),
                          Spacer(),
                          // Spacer to push the length and weight to the right
                          Text(
                            BabySize(week),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 88, 119, 161),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        Babyfactor(week),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Your baby is big as " + FruitSize(week),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 88, 119, 161),
                            ),
                          ),
                          Image.asset(
                            "assets/images/pregnancy-home/size/$week.png",
                            height: 100,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
      bottomNavigationBar: const CreateBottomNavigationBar(pageIndex: 1),
    );
  }
}

int CalculateCurrentWeek(BuildContext context) {
  DateTime? dueDate = context.read<UserProvider>().user?.dueDate;

  if (dueDate != null) {
    final currentDate = DateTime.now();
    final difference = dueDate.difference(currentDate);
    final remainingWeeks = (difference.inDays / 7).ceil();
    int week = 40 - remainingWeeks;
    return week;
  }

  return 0; // If there's no due date available
}

int CalculateDays(BuildContext context) {
  DateTime? dueDate = context.read<UserProvider>().user?.dueDate;
  if (dueDate != null) {
    final currentDate = DateTime.now();
    final difference = dueDate.difference(currentDate);
    final remDays = difference.inDays;
    return remDays;
  }

  return 0; // If there's no due date available
}

String FruitSize(int week) {
  List<String> fruits = [
    "no",
    "no",
    "a vanilla bean seed",
    "a poppy seed",
    "an orange seed",
    "a sweet pea",
    "a blueberry",
    "a raspberry",
    "a green olive",
    "a prune",
    "a strawberry",
    "a lime",
    "a lemon",
    "an orange",
    "a pear",
    "an avocado",
    "a large onion",
    "a cucumber",
    "a mango",
    "a sweet potato",
    "a banana",
    "a papaya",
    "a carrot",
    "a corn cob",
    "a brinjal",
    "a squash",
    "a cabbage",
    "a head of lettuce",
    "a head of cauliflower",
    "a beet",
    "a coconut",
    "a bunch of celery",
    "a butternut squash",
    "a pineapple",
    "a bunch of spinach beet",
    "a bunch of kale",
    "a honeydew melon",
    "a watermelon",
    "a jackfruit",
    "a pumpkin"
  ];
  if (week >= 1 && week <= fruits.length) {
    return fruits[week - 1];
  } else {
    return "a pumpking";
  }
}

String BabySize(int week) {
  List<String> size = [
    "No baby yet",
    "No baby yet",
    "Baby's super tiny",
    "Baby's super tiny",
    "Baby's super tiny",
    "0.5 - 0.6 cm",
    "0.6 cm",
    "1.3 cm",
    "2.5 cm",
    "3.2 - 3.8 cm"
        "3.8 cm, 7 g",
    "5.1 - 5.7 cm, 14 g",
    "7.6 cm, 28 g",
    "8.9 - 10.2 cm, 57 g",
    "10.2 cm, 71 g",
    "10.2 - 12.7 cm, 0.09 - 0.11 kg",
    "12.7 cm, 0.14 kg",
    "14 cm, 0.14 - 0.18 kg",
    "15.2 cm, 0.23 kg",
    "16.5 cm, 0.28 kg",
    "26.7 cm, 0.31 - 0.35 kg",
    "27.9 cm, 0.45 kg",
    "27.9 cm, 0.54 kg",
    "29.2 cm, 0.59 kg",
    "33 cm, 0.68 kg",
    "36 cm, 0.91 kg",
    "37 cm, 0.91 kg",
    "38 cm, 1 kg",
    "39 - 41 cm, 1.1 - 1.4 kg",
    "41 cm, 1.4 kg",
    "41 cm, 1.5 kg",
    "41 - 43 cm, 1.6 - 1.8 kg",
    "43 cm, 1.9 kg",
    "43 - 46 cm, 2.3 kg",
    "46 cm, 2.4 kg",
    "46 - 48 cm, 2.7 kg",
    "48 cm, 2.9 kg",
    "48 - 51 cm, 3.2 kg",
    "48 - 53 cm, 3.2 - 3.6 kg",
    "48 - 56 cm, 3.2 - 4.1 kg"
  ];
  if (week >= 1 && week <= size.length) {
    return size[week - 1];
  } else {
    return "48 - 56 cm, 3.2 - 4.1 kg";
  }
}

String Babyfactor(int week) {
  final List<String> babyGrowthFactors = [
    "Conception and implantation",
    "Early development begins as the embryo forms. The neural tube is forming, which will become the baby's brain and spinal cord.",
    "Major organ formation, including the heart, begins. The heart starts beating, and blood begins to circulate.",
    "The fetus's heartbeat starts and can be detected. The digestive system and lungs begin development.",
    "Limb buds appear, and the eyes and ears start to form. The fingers and toes become more defined.",
    "Facial features, including eyes and a nose, become more pronounced. Taste buds are forming.",
    "The fetus is growing and developing rapidly. The baby's liver and kidney functions begin.",
    "Fingers and toes are now visible on the developing baby. The baby can begin to make small movements.",
    "The fetus becomes sensitive to touch, responding to stimuli. The baby's eyelids are forming.",
    "Vocal cords begin to develop, preparing for future communication. The baby can hiccup.",
    "Gender determination is possible through ultrasound. The baby's fingernails and toenails are forming.",
    "Reflexes develop in the fetus, such as sucking and swallowing. The baby can make facial expressions.",
    "The fetus can make facial expressions, like frowning and squinting. The baby is capable of sucking its thumb.",
    "Nails and hair start forming on the baby's body. The baby's digestive system begins to produce meconium.",
    "Fetal movements become more noticeable to the mother. The baby's bones are hardening.",
    "Rapid brain development continues, shaping cognitive abilities. The baby's body is covered in lanugo, a fine, downy hair.",
    "The fetus can hear sounds from the external environment. The baby's eyes can perceive light.",
    "Development of a sense of equilibrium and balance. The baby is practicing reflexes, like gripping.",
    "The baby's skin is covered with a protective substance called vernix. The baby can recognize its mother's voice.",
    "Fine hair called lanugo appears on the fetus's body. The baby has grown eyebrows and eyelashes.",
    "The fetus can suck its thumb for comfort. The baby's taste buds are fully developed.",
    "Eyebrows and eyelashes begin to form on the baby's face. The baby's skin begins to smooth out as fat accumulates.",
    "The baby develops a regular sleep-wake cycle. The baby's immune system is becoming more robust.",
    "The fetus becomes viable outside the womb, although premature. The baby can respond to changes in light and sound.",
    "Lung development continues, preparing for breathing after birth. The baby is becoming more active with noticeable kicks.",
    "Brain growth accelerates as the cerebral cortex expands. The baby can open and close its eyes.",
    "The baby's lungs continue to mature, producing surfactant. The baby's body is covered in fine hair called lanugo.",
    "The fetus can now open and close its eyes. The baby can recognize and respond to its mother's voice.",
    "Developing fat stores help regulate the baby's temperature. The baby's sense of touch is well-developed.",
    "Senses, such as taste and smell, are further developing. The baby is now blinking and moving its eyes more frequently.",
    "The fetus's immune system begins to strengthen. The baby is practicing breathing movements, inhaling and exhaling amniotic fluid.",
    "Rapid weight gain as the baby accumulates fat reserves. The baby is beginning to settle into the head-down position in preparation for birth.",
    "The baby practices breathing movements in preparation for birth. The baby is becoming less active as it grows larger.",
    "Improved control over body temperature. The baby's brain is now regulating its body temperature.",
    "Growth slows down, but organ maturation continues. The baby is well-positioned for birth in the head-down position.",
    "The baby assumes a head-down position in preparation for birth. The baby's nails may extend beyond its fingertips.",
    "The fetus is considered full-term and ready for delivery. The baby's organs are fully developed and functional.",
    "Lanugo (fine hair) starts to disappear from the baby's skin. The baby continues to gain weight and mature as it approaches birth.",
    "The baby is fully developed and can be born at any time. The baby has reached full-term development and can arrive anytime.",
    "Due date! The baby can arrive anytime now. You're in the final stages of pregnancy, and labor can begin at any moment.",
  ];

  if (week >= 1 && week <= babyGrowthFactors.length) {
    return babyGrowthFactors[week - 1];
  } else {
    return "Congratulations! Your baby has arrived and is in your arms.";
  }
}
