// workout_detail_page.dart
import 'package:flutter/material.dart';

class WorkoutDetailPage extends StatefulWidget {
  final List<Map<String, String>> workouts;
  final int currentIndex;

  const WorkoutDetailPage({
    super.key,
    required this.workouts,
    required this.currentIndex,
  });

  @override
  // ignore: library_private_types_in_public_api
  _WorkoutDetailPageState createState() => _WorkoutDetailPageState();
}

class _WorkoutDetailPageState extends State<WorkoutDetailPage> {
  @override
  Widget build(BuildContext context) {
    final workout = widget.workouts[widget.currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Dark background
      appBar: AppBar(
        title: Text(workout['title'] ?? 'Workout Detail'),
        backgroundColor: Colors.deepOrange,
        actions: [
          if (widget.currentIndex > 0)
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkoutDetailPage(
                      workouts: widget.workouts,
                      currentIndex: widget.currentIndex - 1,
                    ),
                  ),
                );
              },
            ),
          if (widget.currentIndex < widget.workouts.length - 1)
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkoutDetailPage(
                      workouts: widget.workouts,
                      currentIndex: widget.currentIndex + 1,
                    ),
                  ),
                );
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the workout image
            if (workout['videoUrl'] != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  workout['videoUrl']!,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 16),
            // Workout Title
            Text(
              workout['title'] ?? '',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            // Workout Subtitle
            Text(
              workout['subtitle'] ?? '',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 16),
            // Workout Description
            Text(
              workout['description'] ?? '',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 16),
            // You can add a video player here using workout['videoUrl']
            // For example, using the `video_player` package
          ],
        ),
      ),
    );
  }
}
