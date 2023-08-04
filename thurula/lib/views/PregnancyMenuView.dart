import 'package:flutter/material.dart';
// import 'package:thurula/views/widgets/wave_widget.dart';
import 'package:thurula/views/MenuView.dart';
import 'package:thurula/views/PregnancyTimelineView.dart';

// import 'package:provider/provider.dart';

class PregnancyMenuView extends StatelessWidget {
  const PregnancyMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    // final model = Provider.of<HomeModel>(context);

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 227, 227, 227),
        body: GridView.count(crossAxisCount: 3, children: [
          //Pregnancy Timeline
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: InkResponse(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PregnancyTimelineView(),
                    ),
                  );
                },
                child: Container(
                  width: 200,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: Image.asset(
                            'assets/images/menu-icons/timeline.png',
                            height: 60),
                      ),
                      const SizedBox(height: 20),
                      const Text('Pregancny Timeline',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color.fromARGB(255, 220, 104, 145),
                              fontSize: 13,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              )),
          //Health Monitoring
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: InkResponse(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MenuView(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: Image.asset(
                            'assets/images/menu-icons/healthcare.png',
                            height: 60),
                      ),
                      const SizedBox(height: 20),
                      const Text('Health Monitoring',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color.fromARGB(255, 220, 104, 145),
                              fontSize: 13,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              )),
          //Exercise Recommendations
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: InkResponse(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MenuView(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: Image.asset(
                            'assets/images/menu-icons/exercises.png',
                            height: 60),
                      ),
                      const SizedBox(height: 20),
                      const Text('Exercise\nRecommendations',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color.fromARGB(255, 220, 104, 145),
                              fontSize: 13,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              )),
          //Baby Name Suggestions
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: InkResponse(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MenuView(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: Image.asset(
                            'assets/images/menu-icons/healthcare.png',
                            height: 60),
                      ),
                      const SizedBox(height: 20),
                      const Text('Health Monitoring',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color.fromARGB(255, 220, 104, 145),
                              fontSize: 13,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              )),
          //Exercise Recommendations
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: InkResponse(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MenuView(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: Image.asset('assets/images/menu-icons/names.png',
                            height: 60),
                      ),
                      const SizedBox(height: 20),
                      const Text('Baby Name\nSuggestions',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color.fromARGB(255, 220, 104, 145),
                              fontSize: 13,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              )),
//Food Recommendations
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: InkResponse(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MenuView(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: Image.asset('assets/images/menu-icons/food.png',
                            height: 60),
                      ),
                      const SizedBox(height: 20),
                      const Text('Food\nRecommendations',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color.fromARGB(255, 220, 104, 145),
                              fontSize: 13,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              )),
//Forum
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: InkResponse(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MenuView(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: Image.asset('assets/images/menu-icons/forum.png',
                            height: 60),
                      ),
                      const SizedBox(height: 20),
                      const Text('Forum',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color.fromARGB(255, 220, 104, 145),
                              fontSize: 13,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              )),
          // Product Recommendations
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: InkResponse(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MenuView(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: Image.asset(
                            'assets/images/menu-icons/products.png',
                            height: 60),
                      ),
                      const SizedBox(height: 20),
                      const Text('Product\nRecommendations',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color.fromARGB(255, 220, 104, 145),
                              fontSize: 13,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              )),
          //Article Recommendations
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: InkResponse(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MenuView(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: Image.asset(
                            'assets/images/menu-icons/article.png',
                            height: 60),
                      ),
                      const SizedBox(height: 20),
                      const Text('Article\nRecommendations',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color.fromARGB(255, 220, 104, 145),
                              fontSize: 13,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              )),
        ]));
  }
}
