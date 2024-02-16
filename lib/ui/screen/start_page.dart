import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black), // Change color to black
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/gif_search');
          },
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('Start Searching', style: TextStyle(color: Colors.white)), // Optionally, change text color to white
          ),
        ),
      ),
    );
  }
}
