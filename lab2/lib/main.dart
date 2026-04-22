import 'dart:convert';                        // needed to use jsonDecode (converts JSON text to Dart Map)
import 'package:flutter/material.dart';       // Flutter UI library (widgets, colors, etc.)
import 'package:http/http.dart' as http;      // http package to make internet requests

void main() => runApp(const MyApp());         // entry point of the app, runs MyApp

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Future Demo',
      home: const FutureDemo(),               // FutureDemo is our main screen
    );
  }
}

// StatefulWidget because the screen will change (status text updates)
class FutureDemo extends StatefulWidget {
  const FutureDemo({super.key});

  @override
  State<FutureDemo> createState() => _FutureDemoState();
}

class _FutureDemoState extends State<FutureDemo> {

  String _status = 'Press a button';         // this text shows on screen, updates after each button press


  // ── FUNCTION 1: Simple delay ──────────────────────────────────────────────
  // Future<String> means: this function will return a String in the future
  // async means: this function runs in the background (non-blocking)
  Future<String> fetchUserDetail() async {
    await Future.delayed(const Duration(seconds: 3)); // pause 3 seconds without freezing the app
    return 'John Doe — fetched after 3 sec';          // after 3 sec, return this value
  }


  // ── FUNCTION 2: Real API call ─────────────────────────────────────────────
  Future<String> fetchFromApi() async {
    final response = await http.get(                              // send GET request to the URL, wait for response
      Uri.parse('https://jsonplaceholder.typicode.com/users/1'), // free fake API for practice
    );
    if (response.statusCode == 200) {                            // 200 = success
      final data = jsonDecode(response.body);                    // convert JSON string → Dart Map
      return 'API User: ${data['name']}';                        // pull out the "name" field and return it
    } else {
      throw Exception('Failed to load user');                    // non-200 = something went wrong
    }
  }


  // ── FUNCTION 3: Error handling ────────────────────────────────────────────
  Future<void> fetchWithError() async {        // Future<void> = no return value, just does something
    try {
      await Future.delayed(const Duration(seconds: 1)); // wait 1 second
      throw Exception('Simulated network error!');       // force an error to happen
    } catch (e) {                                        // catch the error (e = the error message)
      setState(() => _status = 'Caught error: $e');      // update UI with the error message
    }
  }


  // ── FUNCTION 4: Parallel futures ─────────────────────────────────────────
  Future<void> fetchInParallel() async {
    setState(() => _status = 'Running in parallel...');  // update UI immediately
    final results = await Future.wait([                  // run all 3 at the SAME time, wait for all to finish
      Future.delayed(const Duration(seconds: 1), () => 'Task A done'), // finishes at 1s
      Future.delayed(const Duration(seconds: 2), () => 'Task B done'), // finishes at 2s (slowest)
      Future.delayed(const Duration(seconds: 1), () => 'Task C done'), // finishes at 1s
    ]);                                                  // total wait = 2s, NOT 1+2+1 = 4s
    setState(() => _status = results.join(' | '));        // join all results into one string and show
  }


  // ── UI ────────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Future & Async Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16),       // space around everything
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // buttons stretch full width
          children: [

            // status box — shows what is happening
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(_status, style: const TextStyle(fontSize: 16)), // display current status
            ),

            const SizedBox(height: 24), // vertical space


            // ── BUTTON 1: Future.delayed ──────────────────────────────
            ElevatedButton(
              onPressed: () async {                                    // async because we use await inside
                setState(() => _status = 'Fetching user...(3s)');     // show loading text immediately
                final result = await fetchUserDetail();               // wait for the Future to complete
                setState(() => _status = result);                     // update UI with the returned value
              },
              child: const Text('1. Fetch User (delayed 3s)'),
            ),

            const SizedBox(height: 8),


            // ── BUTTON 2: FutureBuilder ───────────────────────────────
            // FutureBuilder automatically handles loading / done / error states
            ElevatedButton(
              onPressed: () {
                showDialog(                                  // open a popup dialog
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('FutureBuilder Demo'),
                    content: SizedBox(
                      height: 80,
                      child: FutureBuilder<String>(
                        future: fetchUserDetail(),           // the Future to watch
                        builder: (context, snapshot) {      // snapshot = current state of the Future
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator()); // still running → spinner
                          }
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');  // failed → show error
                          }
                          return Text(snapshot.data ?? 'No data');    // done → show result
                        },
                      ),
                    ),
                  ),
                );
              },
              child: const Text('2. FutureBuilder (auto loading/error/done)'),
            ),

            const SizedBox(height: 8),


            // ── BUTTON 3: Real API call ───────────────────────────────
            ElevatedButton(
              onPressed: () async {
                setState(() => _status = 'Calling API...');  // show loading text
                try {
                  final result = await fetchFromApi();        // make the real internet request
                  setState(() => _status = result);           // success → show API result
                } catch (e) {
                  setState(() => _status = 'API error: $e'); // failure → show error (e.g. no internet)
                }
              },
              child: const Text('3. Call REST API'),
            ),

            const SizedBox(height: 8),


            // ── BUTTON 4: Simulate error ──────────────────────────────
            ElevatedButton(
              onPressed: () {
                setState(() => _status = 'About to crash...'); // show text before error
                fetchWithError();                               // call the function (error is caught inside it)
              },
              child: const Text('4. Simulate Error (try/catch)'),
            ),

            const SizedBox(height: 8),


            // ── BUTTON 5: Parallel futures ────────────────────────────
            ElevatedButton(
              onPressed: fetchInParallel,    // directly pass the function (no extra wrapper needed)
              child: const Text('5. Future.wait — run in parallel'),
            ),

          ],
        ),
      ),
    );
  }
}