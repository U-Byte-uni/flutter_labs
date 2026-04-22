import 'package:flutter/material.dart';
import 'package:quiz/Controllers/supabase_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseController.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = SupabaseController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Supabase')),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: ()  {
                controller.fetchUsers();
              },
              child: const Text('Fetch Users'),
            ),
          ),

           ElevatedButton(
            onPressed: ()  {
              controller.saveData();
            },
            child: const Text('Save data'),
          ),
        ],
      ),
    );
  }
}