import 'package:flutter/material.dart';
import 'patient_search_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Patient Management System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PatientSearchScreen(), // Specify the initial screen here
    );
  }
}
