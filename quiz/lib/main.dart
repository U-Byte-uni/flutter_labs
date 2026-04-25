import 'package:flutter/material.dart';
import 'package:quiz/Controllers/education_controller.dart';
import 'package:quiz/Screens/education_form_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EducationController.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Education Form',
      home: EducationFormScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}