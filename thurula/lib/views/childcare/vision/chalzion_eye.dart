import 'package:flutter/material.dart';
import 'package:thurula/views/childcare/child_care_menu_view.dart';
// import '../../signup/Question2View.dart';

class ChalzionEye extends StatelessWidget {
  const ChalzionEye({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(children: [Text('Style and Chalzion Eye')]),
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
                  'What Causes a Stye?',
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
                "A stye (also called a hordeolum) is a small, red, painful lump that grows from the base of your eyelash or under the eyelid. Most styes are caused by a bacterial infection.",
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
                "There are two kinds of styes:",
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
                "1. External hordeolum: A stye that begins at the base of your eyelash. Most are caused by an infection in the hair follicle. It might look like a pimple.",
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
                "2. Internal hordeolum: A stye inside your eyelid. Most are caused by an infection in an oil-producing gland in your eyelid.",
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
                "You can also get a stye if you have blepharitis. This is a condition that makes your eyelids at the base of the eyelashes red and swollen. When you first get a stye, your eyelid is probably red and tender to the touch. Your eye may also feel sore and scratchy.",
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
                  'What Is the Cause of a Chalazion?',
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
                "A chalazion is a swollen bump on the eyelid. It happens when the eyelid’s oil gland clogs up. It may start as an internal hordeolum (stye). At first, you might not know you have a chalazion as there is little or no pain. But as it grows, your eyelid may get red, swollen, and sometimes tender to touch. If the chalazion gets large, it can press on your eye and cause blurry vision. Rarely, the whole eyelid might swell.",
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
                  "What Is the Difference Between a Stye and a Chalazion?",
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
                "Sometimes it can be difficult to tell the difference between a stye and a chalazion.",
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
                "A stye is very painful. It often appears at the eyelid’s edge, usually caused by an infected eyelash root. It often swells, sometimes affecting the entire eyelid.",
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
                " chalazion is not usually painful. It is a bump that usually develops farther back on the eyelid than a stye. It is caused by a clogged oil gland. Rarely does it make the entire eyelid swell.",
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
                  "Stye and Chalazion Symptoms",
                  style: TextStyle(
                    color: Color.fromARGB(255, 88, 119, 161),
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        )));
  }
}
