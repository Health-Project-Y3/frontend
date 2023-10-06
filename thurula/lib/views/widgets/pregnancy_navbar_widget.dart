import 'package:flutter/material.dart';
import 'package:thurula/views/menu_view.dart';

// pregnancy pages
import 'package:thurula/views/pregnancy/pregnancy_exercises/pregnancy_exercise_recommendations_view.dart';
import 'package:thurula/views/pregnancy/pregnancy_timeline_view.dart';
import 'package:thurula/views/pregnancy/pregnancy_vaccination_tracker_view.dart';
import 'package:thurula/views/pregnancy/mother_health_tracker.dart';
import 'package:thurula/views/pregnancy/pregnancy_baby_names_view.dart';
import 'package:thurula/views/forum/forum_home_view.dart';

// childcare pages
import 'package:thurula/views/childcare/exercise/ExerciseView.dart';
import 'package:thurula/views/childcare/growth_chart_view.dart';
import 'package:thurula/views/childcare/vaccination_tracker_view.dart';
import 'package:thurula/views/childcare/vision/VisionMenuView.dart';
import 'package:thurula/views/childcare/diaper_change.dart';
import 'package:thurula/views/childcare/nap/nap_details.dart';
import 'package:thurula/views/childcare/meal_tracker.dart';


// create bottom navigation bar for pregnancy
class CreatePregnancyBottomNavigationBar extends StatelessWidget {
  const CreatePregnancyBottomNavigationBar({super.key, required this.pageIndex});

  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      selectedItemColor: const Color.fromARGB(255, 88, 119, 161),
      unselectedItemColor: const Color.fromARGB(255, 220, 104, 145),
      selectedIconTheme: const IconThemeData(size: 30),
      selectedLabelStyle: const TextStyle(height: 0),
      type: BottomNavigationBarType.fixed,

      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.forum), label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.timeline), label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety), label: ''),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.vaccines), label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center), label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.book), label: ''),
      ],
      currentIndex: pageIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ForumHomeView(),
              ),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PregnancyTimelineView(),
              ),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MotherHealthTracker(),
              ),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MenuView(),
              ),
            );
            break;
          case 4:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PregnancyVaccinationTrackerView(),
              ),
            );
            break;
          case 5:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExercisesView(),
              ),
            );
            break;
          case 6:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BabyNames(),
              ),
            );
            break;
        }
      },
    );
  }
}

//create bottom navigation bar for childcare
class CreateChildcareBottomNavigationBar extends StatelessWidget {
  const CreateChildcareBottomNavigationBar({super.key, required this.pageIndex});

  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      selectedItemColor: const Color.fromARGB(255, 88, 119, 161),
      unselectedItemColor: const Color.fromARGB(255, 220, 104, 145),
      selectedIconTheme: const IconThemeData(size: 30),
      selectedLabelStyle: const TextStyle(height: 0),
      type: BottomNavigationBarType.fixed,

      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.forum), label: ''),
        // growth charts
        BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety), label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.bedtime), label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.vaccines), label: ''),

        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.baby_changing_station), label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.restaurant), label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.checklist), label: ''),
      //   vision test
        BottomNavigationBarItem(
            icon: Icon(Icons.remove_red_eye), label: ''),

      ],
      currentIndex: pageIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ForumHomeView(),
              ),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const GrowthChartView(),
              ),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NapDetails(),
              ),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const VaccinationTrackerView(),
              ),
            );
            break;
          case 4:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MenuView(),
              ),
            );
            break;
          case 5:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DiaperChange(),
              ),
            );
            break;
          case 6:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MealTracker(),
              ),
            );
            break;
          case 7:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ExerciseView(),
              ),
            );
            break;
          case 8:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const VisionMenuView(),
              ),
            );
            break;
          default:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MenuView(),
              ),
            );
        }
      },
    );
  }
}