import 'package:flutter/material.dart';

class HomeWorkoutDetailedPage extends StatelessWidget {
  const HomeWorkoutDetailedPage({super.key});

  static const Map<String, String> detailedData = {
    "title": "Home Workout",
    "imagePath": "lib/images/body/01-fullbody.webp",
    "description": "This workout focuses on full body conditioning using body-weight exercises.",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Workout Details'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                detailedData["imagePath"]!,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              detailedData["title"]!,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              detailedData["description"]!,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
