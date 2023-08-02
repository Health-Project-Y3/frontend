import 'package:flutter/material.dart';
import 'package:thurula/views/LoginView.dart';
import 'package:thurula/views/PregnancyTimelineView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: PregnancyTimelineView());
  }
}
