import 'package:flutter/material.dart';

void main()
{
runApp(First());
}


class First extends StatelessWidget {
  const First({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Row(
          children: [
            Text("FIRST TEXT",style: TextStyle(),),
            Text("FIRST TEXT",style: TextStyle(),),
            Column(
              children: [
                Text("Second"),
                Text("Second"),
              ],
            )

          ],
        ),
      ),
    );
  }
}

