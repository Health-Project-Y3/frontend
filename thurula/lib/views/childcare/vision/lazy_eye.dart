import 'package:flutter/material.dart';
import 'package:thurula/views/childcare/child_care_menu_view.dart';
// import '../../signup/Question2View.dart';

class LazyEye extends StatelessWidget {
  const LazyEye({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(children: [Text('Lazy Eye')]),
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
                  'What Is Lazy Eye?',
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
                "Amblyopia is when vision in one or both eyes does not develop properly during childhood. It is sometimes called lazy eye. Amblyopia is a common problem in babies and young children.",
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
                  'Amblyopia Diagnosis',
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
                "Ophthalmologists diagnose amblyopia by checking to see if vision differs between the two eyes. To check a baby's or young child's vision, the ophthalmologist may cover one of the child's eyes and watch how well they can follow a moving object. The doctor may also watch how the child reacts when one eye is covered. If one eye has amblyopia and the other is covered, the child may try to look above or below the patch, pull it off or cry. The ophthalmologist will do a complete medical eye exam, looking for other eye problems that could be affecting vision. Poor vision in one eye does not always mean a child has amblyopia. In some cases, wearing glasses to correct a refractive error in one eye can improve vision.",
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
                  "When Should a Child's Vision Be Tested?",
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
                "All children should have their vision checked by their pediatrician, family physician or ophthalmologist at or before their 4th birthday. If there is a family history of misaligned eyes, childhood cataracts or serious eye disease, an ophthalmologist should check their eyes when they are an infant. Most doctors test vision as part of a child's medical exam. If they see any sign of eye problems, they may send a child to an ophthalmologist for further tests.",
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
                  "Amblyopia Treatment",
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
                "Amblyopia is usually corrected by making the child use their weaker eye. This is often done by putting a patch over the child’s stronger eye. In some cases, eye drops can be used to blur vision in the stronger eye. Or the child may wear eyeglasses with a lens that blurs vision in that eye. It generally takes several weeks to several months to strengthen vision in the weaker eye. Once the child has better vision in that eye, they may need to wear an eye patch part-time for a few years. This is because there is a chance that eye can weaken again. Remember to keep all appointments with the child’s ophthalmologist who will carefully monitor your child’s vision.",
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
