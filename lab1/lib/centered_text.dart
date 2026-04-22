import 'package:flutter/material.dart';

class CenteredText extends StatelessWidget {
  const CenteredText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Hello world",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 21,
        ),
      ),
    );
  }
}
