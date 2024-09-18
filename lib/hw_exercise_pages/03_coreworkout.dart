import 'package:flutter/material.dart';

class CoreWorkoutPage extends StatelessWidget {
  final String title;
  final String description;

  // ignore: use_key_in_widget_constructors
  const CoreWorkoutPage({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF151515), // Body background color
      appBar: AppBar(title: Text(
      title, style: const TextStyle(color: Colors.deepOrange),),
      backgroundColor: const Color.fromARGB(255, 22, 22, 22),
      foregroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(description,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white70,
            height: 1.0, // Line height - reduces the space between lines
          ), 
        ),
      ),
    );
  }
}