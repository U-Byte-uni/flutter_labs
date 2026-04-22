import 'package:flutter/material.dart';
import 'centered_text.dart';

class TestContainer extends StatelessWidget {
  TestContainer({
    super.key,
    required this.Colors,
    this.start_dir,
    this.end_dir,
  });

  List<Color> Colors;
  AlignmentGeometry? start_dir;
  AlignmentGeometry? end_dir;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: Colors,
          begin: start_dir ?? Alignment.topLeft,
          end: end_dir ?? Alignment.bottomRight,
        ),
      ),
      child: const CenteredText(),
    );
  }
}
