import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thurula/models/baby_model.dart';
import 'package:thurula/services/baby_length_service.dart';
import 'package:thurula/services/baby_service.dart';
import 'package:thurula/services/baby_weight_service.dart';
import 'package:thurula/services/local_service.dart';
import 'package:thurula/services/vaccination_service.dart';
import 'package:thurula/views/childcare/add_new_baby.dart';
import 'package:thurula/views/childcare/exercise/ExerciseView.dart';
import 'package:thurula/views/childcare/growth_chart_view.dart';
import 'package:thurula/views/childcare/vaccination_tracker_view.dart';
import 'package:thurula/views/childcare/vision/VisionMenuView.dart';
import 'package:thurula/views/childcare/diaper_records.dart';
import 'package:thurula/views/childcare/nap/nap_details.dart';
import 'package:thurula/views/childcare/feeding.dart';
import 'package:thurula/views/widgets/expandable_fab_widget.dart';
import '../../providers/baby_provider.dart';
import '../../providers/user_provider.dart';
import '../widgets/navbar_widget.dart';

class ChildHomeView extends StatefulWidget {
  const ChildHomeView({Key? key}) : super(key: key);

  @override
  _ChildHomeViewState createState() => _ChildHomeViewState();
}

class _ChildHomeViewState extends State<ChildHomeView> {
  List<Baby> babies = [];
  ValueNotifier<Baby?> selectedBabyNotifier = ValueNotifier<Baby?>(null);

  @override
  void initState() {
    super.initState();
    loadBabies();
  }

  Future<void> loadBabies() async {
    var user = context.read<UserProvider>().user!;
    List<Baby> loadedBabies = [];
    for (var babyId in user.babyIDs!) {
      Baby? baby = await BabyService.getBaby(babyId);
      if (baby != null) {
        loadedBabies.add(baby);
      }
    }
    setState(() {
      babies = loadedBabies;
      if (babies.isNotEmpty) {
        selectedBabyNotifier.value = babies[0]; // Set first baby in the list
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const CreateChildcareExpandableFab(),
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      body: ValueListenableBuilder<Baby?>(
        valueListenable: selectedBabyNotifier,
        builder: (context, selectedBaby, _) {
          return Stack(
            children: [
              Positioned(
                top: 20,
                left: 25,
                child: Row(
                  children: [
                    Text(
                      'Welcome, ${context.read<UserProvider>().user?.fname ?? ''}',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 88, 119, 161),
                        fontFamily: 'Inter',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 25),
                    GestureDetector(
                      onTap: () {
                        showPopupMenu(context);
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.account_circle,
                            color: Color.fromARGB(255, 220, 104, 145),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            selectedBaby?.fname ?? '',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 220, 104, 145),
                              fontFamily: 'Inter',
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 35,
                left: 15,
                right: 20,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      // Growth Tracker
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkResponse(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GrowthChartView(),
                              ),
                            );
                          },
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                                ClipRRect(
                                  child: Image.asset(
                                    'assets/images/menu-tiles/growth.png',
                                    height: 70,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text("Growth Tracker",
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color:
                                            Color.fromARGB(255, 88, 119, 161),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Vaccination Tracker
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkResponse(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const VaccinationTrackerView(),
                              ),
                            );
                          },
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                                ClipRRect(
                                  child: Image.asset(
                                    'assets/images/menu-tiles/vaccine.png',
                                    height: 70,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text("Vaccination Tracker",
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color:
                                            Color.fromARGB(255, 88, 119, 161),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Nap Time Monitoring
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkResponse(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NapDetails(),
                              ),
                            );
                          },
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                                ClipRRect(
                                  child: Image.asset(
                                    'assets/images/menu-tiles/nap.png',
                                    height: 70,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text("Nap Time Monitoring",
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color:
                                            Color.fromARGB(255, 88, 119, 161),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
//Diaper Change Monitoring
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkResponse(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DiaperRecords(),
                              ),
                            );
                          },
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                                ClipRRect(
                                  child: Image.asset(
                                    'assets/images/menu-tiles/diaper.png',
                                    height: 70,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text("Diaper Change",
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color:
                                            Color.fromARGB(255, 88, 119, 161),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Feeding Monitoring
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkResponse(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FeedingRecords(),
                              ),
                            );
                          },
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                                ClipRRect(
                                  child: Image.asset(
                                    'assets/images/menu-tiles/feeding.png',
                                    height: 70,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text("Feeding Monitoring",
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color:
                                            Color.fromARGB(255, 88, 119, 161),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Skill Development Exercises
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkResponse(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExerciseView(),
                              ),
                            );
                          },
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                                ClipRRect(
                                  child: Image.asset(
                                    'assets/images/menu-tiles/checklist.png',
                                    height: 70,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text("Checklist",
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color:
                                            Color.fromARGB(255, 88, 119, 161),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Skill Development Exercises
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkResponse(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const VisionMenuView(),
                              ),
                            );
                          },
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                                ClipRRect(
                                  child: Image.asset(
                                    'assets/images/menu-tiles/vision.png',
                                    height: 70,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text("Vision Test",
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color:
                                            Color.fromARGB(255, 88, 119, 161),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 190,
                left: 20,
                right: 20,
                child: Container(
                  width: 400,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 2,
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
                            padding: const EdgeInsets.all(10.0),
                            child: ClipRRect(
                              child: Image.asset(
                                'assets/images/child-home/countdown.png',
                                height: 150,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Text(
                              "Baby ${selectedBaby?.fname ?? ''} is ${selectedBaby?.birthDate != null ? AgeCalc(selectedBaby!.birthDate!) : 0} days old",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 88, 119, 161),
                                fontSize: 16.0,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 410,
                left: 20,
                right: 20,
                child: Container(
                  width: 400,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 2,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: FutureBuilder(
                      future: Future.wait([
                        getRecentBabyWeight(selectedBaby?.id ??
                            ""), // Use a default value if selectedBaby is null
                        getRecentBabyLength(selectedBaby?.id ??
                            ""), // Use a default value if selectedBaby is null
                      ]),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color.fromARGB(255, 220, 104, 145)),
                          );
                        } else if (snapshot.hasError) {
                          return const Text("");
                        } else {
                          final List<double?> data =
                              snapshot.data as List<double?>;
                          final recentBabyWeight = data[0];
                          final recentBabyLength = data[1];
                          final displayString =
                              "Baby ${selectedBaby?.fname ?? ''} is\n${recentBabyWeight ?? 'N/A'} kg and ${recentBabyLength ?? 'N/A'} cm";
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                displayString,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 88, 119, 161),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  left: 5.0,
                                  right: 10.0,
                                ),
                              ),
                              Image.asset(
                                'assets/images/child-home/size.png',
                                height: 70,
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Container(
                  width: 400,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 2,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: FutureBuilder<String?>(
                      future: getRecentDue(selectedBaby?.id ??
                          "No due vaccinations"), // Use a default value if selectedBaby is null
                      builder: (context, dueSnapshot) {
                        if (dueSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color.fromARGB(255, 220, 104, 145)),
                          );
                        } else if (dueSnapshot.hasError) {
                          return const Text("No due vaccinations");
                        } else {
                          final dueMessage =
                              dueSnapshot.data ?? "No due vaccinations found";
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              dueMessage, // Display the due message here
                              style: const TextStyle(
                                color: Color.fromARGB(255, 220, 104, 145),
                                fontSize: 17.0,
                                height: 1.5,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: const CreateBottomNavigationBar(
        pageIndex: 1,
      ),
    );
  }

  void showPopupMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Baby Profiles'),
          contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var baby in babies)
                RadioListTile(
                  title: Text(baby.fname ?? ''),
                  value: baby,
                  groupValue: selectedBabyNotifier.value,
                  onChanged: (value) {
                    final babyProvider =
                        Provider.of<BabyProvider>(context, listen: false);
                    babyProvider.setBaby(value!);
                    LocalService.setCurrentBabyId(value.id!);
                    selectedBabyNotifier.value = value;
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              const SizedBox(height: 10),
            ],
          ),
          actions: [
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddNewBaby(),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 220, 104, 145),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 88, 119, 161),
                ),
                child: const Text('Close'),
              ),
            ),
          ],
        );
      },
    );
  }
}

int AgeCalc(DateTime birthday) {
  final currentDate = DateTime.now();
  final difference = currentDate.difference(birthday);
  final ageInDays = difference.inDays;
  return ageInDays;
}

Future<double?> getRecentBabyWeight(String Id) async {
  final babyWeightService = BabyWeightService(); // Create an instance
  final validWeights = await babyWeightService.getRecentBabyWeight(Id);

  if (validWeights != null) {
    final mostRecentWeight =
        validWeights; // Get the most recent non-negative weight
    return mostRecentWeight.toDouble();
  } else {
    return null; // Return null if there are no valid weights
  }
}

Future<double?> getRecentBabyLength(String Id) async {
  final babyLengthService = BabyLengthService(); // Create an instance
  final validLengths = await babyLengthService.getRecentBabyLength(Id);

  if (validLengths != null) {
    final mostRecentLenght =
        validLengths; // Get the most recent non-negative weight
    return mostRecentLenght.toDouble();
  } else {
    return null; // Return null if there are no valid weights
  }
}

Future<String?> getRecentDue(String Id) async {
  final vaccinationService = VaccinationService(); // Create an instance
  final dueDate = await vaccinationService.getFirstDueVaccine(Id);
  final difference = dueDate;
  if (difference! < 0) {
    return "Baby's next vaccination is overdue";
  } else if (difference < 31) {
    return "Next vaccination is due in $difference days";
  } else {
    final months = difference ~/ 30;
    return "Next vaccination is due in $months months";
  }
}
