import 'package:flutter/material.dart';
// To handle gestures

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
  late int _currentIndex; // Current index of the workout
  int? _swipeDirection; // -1 for left swipe, 1 for right swipe

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex; // Initialize current index
  }

  void _swipeLeft() {
    // Handle swipe left gesture
    if (_currentIndex < widget.workouts.length - 1) {
      setState(() {
        _swipeDirection = -1; // Set swipe direction to left
        _currentIndex++;
      });
    }
  }

  void _swipeRight() {
    // Handle swipe right gesture
    if (_currentIndex > 0) {
      setState(() {
        _swipeDirection = 1; // Set swipe direction to right
        _currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final workout = widget.workouts[_currentIndex]; // Get current workout

    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Dark background
      appBar: AppBar(
        title: Text(workout['title'] ?? 'Workout Detail'),
        backgroundColor: const Color.fromARGB(255, 22, 22, 22),
        foregroundColor: Colors.deepOrange,
         actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30, top: 5, bottom: 5, left: 10),
            child: Center(
              child: Text(
                '${_currentIndex + 1}/${widget.workouts.length}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        // Detect swipe gestures
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity != null && details.primaryVelocity! < 0) {
            // Swiped Left
            _swipeLeft();
          } else if (details.primaryVelocity != null &&
              details.primaryVelocity! > 0) {
            // Swiped Right
            _swipeRight();
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300), // Animation duration
                switchInCurve: Curves.easeInOut, // Curve for incoming widget
                switchOutCurve: Curves.easeInOut, // Curve for outgoing widget
                transitionBuilder: (Widget child, Animation<double> animation) {
                  // Transition builder for animations
                  final offsetAnimation = Tween<Offset>(
                    begin: Offset(_swipeDirection == -1 ? 1.0 : -1.0, 0.0), // Incoming from left or right
                    end: Offset.zero, // End at original position
                  ).animate(animation);

                  final opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(animation);

                  return FadeTransition(
                    opacity: opacityAnimation,
                    child: SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    ),
                  );
                },
              child: SingleChildScrollView(
                key: ValueKey<int>(_currentIndex), // Unique key for each child
                padding: const EdgeInsets.only( bottom: 16, left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (workout['videoUrl'] != null)
                      SizedBox(
                        // Removed width to allow it to take up available space
                        height: MediaQuery.of(context).size.height / 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            workout['videoUrl']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    const SizedBox(height: 14),
                    Text(
                      workout['title'] ?? '',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      workout['subtitle'] ?? '',
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: Text(
                        workout['description'] ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 20, top: 5),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentIndex > 0)
                      Expanded(
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          iconSize: 28,
                          color: Colors.white,
                          style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(Colors.white60),
                          padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(3)),
                          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                          onPressed: _swipeRight, // Navigate to previous
                        ),
                      ),
                    const SizedBox(width: 16), // Space between buttons
                    if (_currentIndex < widget.workouts.length - 1)
                      Expanded(
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          iconSize: 28,
                          color: Colors.white,
                          style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(Colors.deepOrange),
                          padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(3)),
                          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                          onPressed: _swipeLeft, // Navigate to next
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
