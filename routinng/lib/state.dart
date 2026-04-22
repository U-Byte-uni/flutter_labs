import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selected = 'none';

  void _selectFirst() {
    setState(() {
      _selected = 'second';
    });
  }

  void _selectSecond() {
    setState(() {
      _selected = 'first';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FirstWidget(
              onTap: _selectFirst,
              isLarge: _selected == 'first',
            ),
            SizedBox(width: 20),
            SecondWidget(
              onTap: _selectSecond,
              isLarge: _selected == 'second',
            ),
          ],
        ),
      ),
    );
  }
}

class FirstWidget extends StatefulWidget {
  final VoidCallback onTap;
  final bool isLarge;

  const FirstWidget({super.key, required this.onTap, required this.isLarge});

  @override
  State<FirstWidget> createState() => _FirstWidgetState();
}

class _FirstWidgetState extends State<FirstWidget> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    double size = widget.isLarge ? 200 : 150;

    return Container(
      width: size,
      height: size,
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('First'),
          Text('$_counter'),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _counter++;
              });
            },
            child: const Text('Count'),
          ),
          ElevatedButton(
            onPressed: widget.onTap,
            child: const Text('Select'),
          ),
        ],
      ),
    );
  }
}

class SecondWidget extends StatefulWidget {
  final VoidCallback onTap;
  final bool isLarge;

  const SecondWidget({super.key, required this.onTap, required this.isLarge});

  @override
  State<SecondWidget> createState() => _SecondWidgetState();
}

class _SecondWidgetState extends State<SecondWidget> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    double size = widget.isLarge ? 200 : 150;

    return Container(
      width: size,
      height: size,
      color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Second'),
          Text('$_counter'),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _counter++;
              });
            },
            child: const Text('Count'),
          ),
          ElevatedButton(
            onPressed: widget.onTap,
            child: const Text('Select'),
          ),
        ],
      ),
    );
  }
}