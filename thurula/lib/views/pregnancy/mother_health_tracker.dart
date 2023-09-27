import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MotherHealthTracker(),
  ));
}

class MotherHealthTracker extends StatefulWidget {
  const MotherHealthTracker({Key? key}) : super(key: key);

  @override
  _HealthTrackerState createState() => _HealthTrackerState();
}

class _HealthTrackerState extends State<MotherHealthTracker> {
  bool isModalOpen = false;

  @override
  void initState() {
    super.initState();
    _openModal();
  }

  void _openModal() {
    Future.delayed(Duration.zero, () {
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext context) {
          return ModalContent(
            closeModal: () {
              setState(() {
                isModalOpen = false;
              });
              Navigator.pop(context);
            },
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Tracker'),
        backgroundColor: Color.fromARGB(255, 220, 104, 145),
      ),
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Box 1
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 400,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0.5,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'I weigh',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 88, 119, 161),
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    '65kg',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 88, 119, 161),
                                      fontSize: 36.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'Week on Week Gain - 1.5kg',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 88, 119, 161),
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Container for the image with specified width and height
                          Container(
                            width: 180,
                            height: 180,
                            child: Image.asset(
                              'assets/images/health_tracker/weigh.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Box 3 (Weight Growth Chart)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: WeightChartBox(),
                ),
                // Box 2
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 400,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0.5,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'My Pressure Level',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 88, 119, 161),
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    '0/0',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 88, 119, 161),
                                      fontSize: 36.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'Week on Week Gain - 1.5kg',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 88, 119, 161),
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Container for the image with specified width and height
                          Container(
                            width: 180,
                            height: 180,
                            child: Image.asset(
                              'assets/images/health_tracker/pressure.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Box 4 (Copy the above code with different content)
                Padding(
                  padding: const EdgeInsets.all(5.0),
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
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    // Add content for Box 4 here
                  ),
                ),
              ],
            ),
          ),
          if (isModalOpen)
            Container(
              color: Color.fromRGBO(0, 0, 0, 0.4), // Overlay color
            ),
        ],
      ),
    );
  }
}

class WeightChartBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.5,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: WeightChartView(),
    );
  }
}

class WeightChartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 300,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey),
      ),
      // Add your weight growth chart content here
      // For example, you can use a LineChart or any other chart library.
      // You'll need to import the necessary chart library and implement the chart logic.
    );
  }
}

class ModalContent extends StatelessWidget {
  final Function closeModal;

  ModalContent({required this.closeModal});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 500.0, // Increase the height as needed
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Pre-Pregnancy Details",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: "Before we embark on this incredible journey together, ",
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    TextSpan(
                      text: "Please add your ",
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    TextSpan(
                      text: "pre-pregnancy height and weight",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Color.fromARGB(255, 220, 104, 145),
                      ),
                    ),
                    TextSpan(
                      text: " details to ensure your well-being and a healthy pregnancy.",
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Text("Maintaining a healthy weight and understanding your body's baseline is essential for a successful and comfortable pregnancy."),
              SizedBox(height: 16.0),
              SizedBox(height: 12.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Height (cm/inch)',
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Weight (kg/lbs)',
                ),
              ),
              SizedBox(height: 12.0),
              SizedBox(height: 16.0),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: double.infinity, // Make the button full width
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle submit button logic here
                      // For example, you can get the values from the input fields
                      // and perform some action.
                      closeModal(); // Close the modal using the provided function
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 220, 104, 145), // Pink color
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white), // White text color
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}