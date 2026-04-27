import 'package:flutter/material.dart';
import 'package:quiz/Controllers/controller.dart';
import 'package:quiz/Screens/screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DriverController.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FormWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}