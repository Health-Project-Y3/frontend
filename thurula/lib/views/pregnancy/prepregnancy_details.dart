import 'package:flutter/material.dart';



class prepregnancyDetails extends StatefulWidget {
  const prepregnancyDetails({Key? key}) : super(key: key);

  @override
  _prepregnancyDetailsState createState() => _prepregnancyDetailsState();
}

class _prepregnancyDetailsState extends State<prepregnancyDetails> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize controllers with initial values if available
    heightController.text = 'Initial Height Value';
    weightController.text = 'Initial Weight Value';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health Monitor"),
        backgroundColor: Color.fromARGB(255, 220, 104, 145),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Pre-Pregnancy Details",
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 25.0),
            Text(
              "Before we embark on this incredible journey together, "
                  "Please add your "
                  "pre-pregnancy height and weight details to ensure your well-being and a healthy pregnancy.",
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 16.0),
            Text(
                "Maintaining a healthy weight and understanding your body's baseline is essential for a successful and comfortable pregnancy."),
            SizedBox(height: 16.0),
            SizedBox(height: 12.0),
            TextField(
              controller: heightController,
              decoration: InputDecoration(
                labelText: 'Height (cm/inch)',
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: weightController,
              decoration: InputDecoration(
                labelText: 'Weight (kg/lbs)',
              ),
            ),
            SizedBox(height: 12.0),
            SizedBox(height: 16.0),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button press and data submission here
                    // You can access heightController.text and weightController.text
                    // to get the user's input.
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 220, 104, 145),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            // Add an image with a bottom margin aligned to the bottom of the page
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 0.0), // Adjust margin as needed
                  child: Image.asset(
                    'assets/images/health_tracker/initial_ht.png', // Replace with your image path
                    height: 300.0, // Adjust the height as needed
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
