import 'package:flutter/material.dart';
import 'package:thurula/views/childcare/child_care_menu_view.dart';
// import '../../signup/Question2View.dart';

class PinkEye extends StatelessWidget {
  const PinkEye({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(children: [Text('Pink Eye')]),
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
        body: const SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'What Is Pink Eye?',
                  style: TextStyle(
                    color: Color.fromARGB(255, 88, 119, 161),
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Conjunctivitis—often called “pink eye”—is inflammation of the conjunctiva from infection or allergies. Your eyes are red and swollen (inflamed), and sometimes they have a sticky discharge. You can have conjunctivitis in one or both eyes. Some types of pink eye are very contagious (easily spread from person to person), but many others are not.",
                style: TextStyle(
                  color: Color.fromARGB(255, 88, 119, 161),
                  fontSize: 14.0,
                  height: 1.5,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'What Are the Main Causes of Conjunctivitis?',
                  style: TextStyle(
                    color: Color.fromARGB(255, 88, 119, 161),
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Conjunctivitis can be caused by a virus, bacteria or by allergies. Bacterial and viral conjunctivitis are easily spread from person to person. Allergic conjunctivitis is not contagious.",
                style: TextStyle(
                  color: Color.fromARGB(255, 88, 119, 161),
                  fontSize: 14.0,
                  height: 1.5,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Viral conjunctivitis is the most common type of conjunctivitis. This type of pink eye is very contagious and often spreads through schools and other crowded places. It usually causes burning, red eyes with a watery discharge. Viral conjunctivitis is usually caused by the same virus that causes runny nose and sore throat in people with the common cold.",
                style: TextStyle(
                  color: Color.fromARGB(255, 88, 119, 161),
                  fontSize: 14.0,
                  height: 1.5,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Bacterial conjunctivitis is also very contagious. An infection from bacteria causes this form of pink eye. With bacterial conjunctivitis, you have sore, red eyes with a lot of sticky pus in the eye. Some bacterial infections, however, may cause little or no discharge. Sometimes the bacteria that cause pink eye are the same that cause strep throat.",
                style: TextStyle(
                  color: Color.fromARGB(255, 88, 119, 161),
                  fontSize: 14.0,
                  height: 1.5,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Allergic conjunctivitis is a type of pink eye that comes from an allergic reaction to pollen, animals, cigarette smoke, pool chlorine, car fumes or something else in the environment. It is not contagious. Allergic pink eye makes your eyes very itchy, red and watery, and the eyelids may get puffy.",
                style: TextStyle(
                  color: Color.fromARGB(255, 88, 119, 161),
                  fontSize: 14.0,
                  height: 1.5,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "How Do You Get Conjunctivitis?",
                  style: TextStyle(
                    color: Color.fromARGB(255, 88, 119, 161),
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Bacterial and viral conjunctivitis can be quite contagious. The most common ways to get the contagious form of pink eye include: Direct contact with an infected person's bodily fluids, usually through hand-to-eye contact, Spread of the infection from bacteria living in the person's own nose and sinuses, Not cleaning contact lenses properly. Using poorly fitting contact lenses or decorative contacts are risks as well, Children are the people most likely to get pink eye from bacteria or viruses. This is because they are in close contact with so many others in school or day care centers. Also, they don't practice good hygiene.",
                style: TextStyle(
                  color: Color.fromARGB(255, 88, 119, 161),
                  fontSize: 14.0,
                  height: 1.5,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "How Do I Know If I'm Getting Pink Eye?",
                  style: TextStyle(
                    color: Color.fromARGB(255, 88, 119, 161),
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "the feeling that something is in your eye, or a gritty sensation in your eye, red eyes, burning eyes, itchy eyes, painful eyes , , watery eye, puffy eyelids, blurry or hazy vision, being extra sensitive to light, lots of mucus, pus, or thick yellow discharge from your eye.",
                style: TextStyle(
                  color: Color.fromARGB(255, 88, 119, 161),
                  fontSize: 14.0,
                  height: 1.5,
                ),
              ),
            ),
          ],
        )));
  }
}
