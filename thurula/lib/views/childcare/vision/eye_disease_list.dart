import 'package:flutter/material.dart';
import 'package:thurula/views/childcare/child_care_menu_view.dart';
import 'package:thurula/views/childcare/vision/crossed_eye.dart';
import 'package:thurula/views/childcare/vision/droopy_eye.dart';
import 'package:thurula/views/childcare/vision/eye_cataract.dart';
import 'package:thurula/views/childcare/vision/lazy_eye.dart';
import 'package:thurula/views/childcare/vision/pink_eye.dart';
// import '../../signup/Question2View.dart';
import '../../../constants/eye_disease.dart';

class EyeDiseaseList extends StatelessWidget {
  const EyeDiseaseList({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    // final model = Provider.of<HomeModel>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Row(children: [Text('Eye Diseases')]),
          backgroundColor: const Color.fromARGB(255, 220, 104, 145),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChildCareMenuView()));
                    })),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            for (int x = 1; x <= 7; x++) ...[
              Container(height: 10),
              Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (x == 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LazyEye()));
                      } else if (x == 2) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CrossedEye()));
                      } else if (x == 3) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DroopyEye()));
                      } else if (x == 4) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CataractEye()));
                      } else if (x == 5) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PinkEye()));
                      } else if (x == 6) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LazyEye()));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LazyEye()));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.white,
                      // Color of the card
                      elevation: 2, // Card elevation
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Image.asset(
                                'assets/images/exercises/secondm1.png',
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(width: 5),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            // exercise card
                            children: <Widget>[
                              Container(height: 5),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, bottom: 5),
                                // exercise title/name
                                child: Text(
                                  eye_disease_list[x - 1],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Inter',
                                    //   color #504E4E
                                    color: Color.fromARGB(255, 80, 78, 78),
                                  ),
                                ),
                              ),
                            ],
                          ))
                        ],
                      ),
                    ),
                  )),
            ]
          ],
        )));
  }
}
