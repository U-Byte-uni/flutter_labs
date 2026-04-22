import 'package:flutter/material.dart';

void main() {
  runApp(const Login());
}

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(child: Text("Login App",
          style: TextStyle(color: Colors.white),
          ),
          ) ,
          backgroundColor: Colors.lightBlue,
          leading: Icon(Icons.menu,
          color: Colors.white,),

        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/login.jpg',
                  width: 200,
                  height: 200,
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Username"
                    ),
                  ),
                ),

                const SizedBox(height: 15.0),

                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Password"
                    ),
                  ),
                ),

                const SizedBox(height: 15.0),

                ElevatedButton.icon(
                  onPressed: () {},
                  icon:  Icon(Icons.login),
                  label: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),

        ),
      ),
    );
  }
}

