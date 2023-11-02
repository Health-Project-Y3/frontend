import 'package:flutter/material.dart';
import 'package:thurula/views/childcare/child_care_menu_view.dart';
// import '../../signup/Question2View.dart';

class CataractEye extends StatelessWidget {
  const CataractEye({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(children: [Text('Eye Cataract')]),
          backgroundColor: const Color.fromARGB(255, 220, 104, 145),
        ),
        body: const SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'What Is Pediatric Cataracts?',
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
                "Many people think cataracts only happen to older people. Children can get cataracts too. The name for cataracts in children is pediatric cataracts. At any age, cataracts are a clouding of the eye's lens. An eye’s lens must be clear to focus the images it sees onto the retina, which then sends the images to the brain. A cataract can prevent light from reaching the retina. It can also cause light rays to scatter as they pass through the cloudiness. This distorts the image and can cause blurry vision or blindness. In adults, cataracts happen after the eyes and vision develop. Most adults have good vision again after they have their cataracts removed. Children's eyes and brains are still developing until they're 8 or 10 years old. That's why untreated cataracts can have serious, permanent effects on their vision.",
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
                  'Types and Causes of Cataracts in Children Vary',
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
                "Cataracts in a child can be congenital (present at birth) or acquired (develop as an infant, child, or adolescent)., Cataracts can happen in one or both eyes. When both eyes have a cataract, one can be worse than the other., Cataracts may appear in different parts of the lens and range in size from tiny dots to dense clouds., Genetics, metabolic disorders like diabetes, and eye injury can all cause cataracts.",
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
                  "Early Detection and Swift Treatment",
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
                "Children's eyes and brain are still learning to see. This is why distortion can lead to lazy eye in children. Without treatment, cataracts can damage connections between the brain and eye. Once made, these connections don't change. This is why finding and treating cataracts early is so important. It can prevent permanent vision loss in children. Doctor exams find many babies' cataracts at birth before they leave the hospital. Pediatricians find more at well-baby checkups. Parents find some of them themselves. Cataracts often show up in exams as a missing or irregular red reflex. Unlike congenital cataracts, acquired cataracts develop sometime after birth. Most often, pediatricians diagnose them at vision screenings or after an eye injury.",
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
