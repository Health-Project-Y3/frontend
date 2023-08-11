import 'package:flutter/material.dart';


//
// class MotherHealthTracker extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyPage(),
//     );
//   }
// }

class MotherHealthTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFDC6891), // Color for the app bar
        title: Text("Mother Health Tracker"), // Updated app bar name
      ),
      backgroundColor: Color(0xFFFFFFFF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey, // You can replace this with an image
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Dushanee Gamage",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5877A1),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DashboardCard(label: "Height", value: "184cm", isBold: true, fontSize: 20),
                SizedBox(width: 16),
                DashboardCard(label: "Weight", value: "63Kg", isBold: true, fontSize: 20),
              ],
            ),
            SizedBox(height: 16),
            Center(
              child: Container(
                width: 200, // Two times the width of the above cards
                child: FullWidthCard(
                  label: "Blood Pressure",
                  value: "88mmHg",
                  isBold: true,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 45),
            FullWidthCard(
              label: "Doctor recommendations",
              value: "You are in good health conditions mummy",
              isBold: true,
              fontSize: 18,
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final double fontSize;

  DashboardCard({required this.label, required this.value, this.isBold = false, this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFFDC6891)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Color(0xFF5877A1),
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: fontSize,
            ),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: Color(0xFF5877A1),
            ),
          ),
        ],
      ),
    );
  }
}

class FullWidthCard extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final double fontSize;

  FullWidthCard({required this.label, required this.value, this.isBold = false, this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFFDC6891)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Color(0xFF5877A1),
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: fontSize,
            ),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: Color(0xFF58CF99),
            ),
          ),
        ],
      ),
    );
  }
}
