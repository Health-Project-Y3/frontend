import 'package:flutter/material.dart';
import 'package:thurula/views/childcare/child_care_menu_view.dart';
// import '../../signup/Question2View.dart';

class CrossedEye extends StatelessWidget {
  const CrossedEye({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(children: [Text('Crossed Eye')]),
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
                  'What Is Adult Strabismus?',
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
                "Adult strabismus (crossed eyes) is when your eyes are not lined up properly and they point in different directions. One eye may look straight ahead while the other eye turns in, out, up, or down. The misalignment can shift from one eye to the other. Strabismus affects vision, since both eyes must aim at the same spot together to see properly.",
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
                  'What Causes Adult Strabismus?',
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
                "To line up and focus both eyes on a single target, all muscles in both eyes must be balanced and working together. The brain controls these muscles. People who have strabismus usually have a problem that can affect eye muscles. Some of those problems may include: Health problems such as diabetes, thyroid disease (Graves’ disease), Myasthenia gravis, brain tumors, or a stroke Accidents or head injury. Damage to eye muscles during some kind of eye surgery. Most adults with strabismus have had it since they were children. But sometimes it starts later in life.",
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
                  "How Does Strabismus Affect Vision?",
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
                "With normal vision, both eyes aim at the same spot. The brain combines the two images from our eyes into a single, three-dimensional (3-D) image. This is how we can tell how near or far something is from us (called depth perception). When one eye is out of alignment, two different pictures are sent to the brain. In a young child, the brain learns to ignore the image of the misaligned eye. Instead, it sees only the image from the straight or better-seeing eye. As a result, the child loses depth perception. Adults who develop strabismus after childhood often have double vision. This is because their brains have already learned to receive images from both eyes. Their brains cannot ignore the image from the turned eye, so they see two images.",
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
                  "What Are the Symptoms of Strabismus (Crossed Eyes)?",
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
                "The most obvious symptom is having eyes that appear out of alignment. Adults with strabismus also may notice these other symptoms: Weakness in or around the eye, or feeling like something is pulling around your eyes. Vision changes, such as double vision (seeing two of one image), blurry vision, trouble reading, or a loss of depth perception. Constantly tilting or turning your head to see an image clearly. Strabismus symptoms can be constant, or they can come and go.",
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
                  "Strabismus (Crossed Eyes) Treatment",
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
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Adult strabismus (crossed eyes) surgery",
                  style: TextStyle(
                    color: Color.fromARGB(255, 155, 88, 161),
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
                "This is the most common treatment for strabismus. Surgery can improve eye alignment and help restore proper vision.Typically, strabismus occurs when the muscles around the eyes are either too stiff or too weak. An ophthalmologist can loosen, tighten, or move certain eye muscles so that the eyes line up properly to work together. More than one surgery may be needed to treat strabismus.Surgery is usually done as outpatient surgery in a hospital or surgery center, using either general or local anesthesia. Your ophthalmologist makes a small cut in the tissue covering the eye to reach the eye muscles. The muscles are then repositioned to help the eyes point in the same direction. This may need to be done in one or both eyes. After strabismus surgery, you can get back to your daily routine within a few days.",
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
                  "Eye muscle exercises",
                  style: TextStyle(
                    color: Color.fromARGB(255, 155, 88, 161),
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
                "An ophthalmologist can teach you exercises to help you focus both eyes inward. These exercises can help if you have “convergence insufficiency.” That is when your eyes do not align properly for close tasks, like reading or computer work.",
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
