import 'package:flutter/material.dart';
import 'package:thurula/views/login_view.dart';
import 'package:thurula/views/nap_details.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false, home: NapDetails());
  }
}
