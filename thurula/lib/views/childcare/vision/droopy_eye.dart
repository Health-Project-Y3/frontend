import 'package:flutter/material.dart';
import 'package:thurula/views/childcare/child_care_menu_view.dart';
// import '../../signup/Question2View.dart';

class DroopyEye extends StatelessWidget {
  const DroopyEye({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(children: [Text('Droopy Eyelid')]),
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
                  'What Is Ptosis?',
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
                "Ptosis is when the upper eyelid droops over the eye. The eyelid may droop just a little, or so much that it covers the pupil (the black dot at the center of your eye that lets light in). Ptosis can limit or even completely block normal vision. Children and adults can have ptosis. Fortunately, this condition can be treated to improve vision as well as appearance.",
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
                  'Ptosis in Children',
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
                "Children born with ptosis have what is called congenital ptosis. This can be caused by problems with the muscle that lifts the eyelid (called the levator muscle). The most obvious sign of ptosis is a drooping eyelid. Another sign is when the upper eyelid creases do not line up evenly with each other. A child with ptosis may tip their head back, lift up their chin, or raise their eyebrows to try to see better. Over time, these movements can cause head and neck problems. Sometimes, a child born with ptosis can also have other eye-related problems. They can include eye movement issues, eye muscle disease, tumors (on the eyelid or elsewhere) and other problems. Having ptosis puts a child at risk for vision problems. If the child’s eyelid droops so much that it blocks vision, amblyopia (also called “lazy eye”) can develop. One eye will have better vision than the other. A child with ptosis can also have astigmatism, where they see blurry images. The child may also develop misaligned (crossed) eyes.",
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
                  "Ptosis Treatment for Children",
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
                "Ophthalmologists consider the following factors when deciding the best way to treat ptosis in children: The child’s age Whether one or both eyelids are involved, The eyelid height The strength of the eyelid’s muscle, The eye’s movements. In most cases, ophthalmologists recommend surgery to treat ptosis in children. This is to either tighten the levator muscle or attach the eyelid to other muscles that can help lift the eyelid. The goal is to improve vision. If the child also has amblyopia, that condition must be treated as well. Amblyopia may be treated by wearing an eye patch or special eyeglasses, or using certain eye drops, to strengthen the weaker eye.",
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
