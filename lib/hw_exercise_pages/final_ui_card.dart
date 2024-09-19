import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WorkoutDetailPage extends StatefulWidget {
  final List<Map<String, String>> workouts;
  final int currentIndex;

  const WorkoutDetailPage({
    super.key,
    required this.workouts,
    required this.currentIndex,
  });

  @override
  _WorkoutDetailPageState createState() => _WorkoutDetailPageState();
}

class _WorkoutDetailPageState extends State<WorkoutDetailPage> {
  PageController? _pageController; // PageController initialized lazily
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;

    // Delayed initialization of _pageController to avoid errors
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _pageController = PageController(initialPage: _currentIndex);
      });
    });
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  void _nextWorkout() {
    if (_currentIndex < widget.workouts.length - 1) {
      _pageController?.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousWorkout() {
    if (_currentIndex > 0) {
      _pageController?.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_pageController == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0), // Custom height for the AppBar
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 22, 22, 22),
          foregroundColor: Colors.deepOrange,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                widget.workouts[_currentIndex]['title'] ?? 'Workout Detail',
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),              
              const SizedBox(height: 8),
              // SmoothPageIndicator placed in the AppBar
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SmoothPageIndicator(
                  controller: _pageController!,
                  count: widget.workouts.length,
                  effect: const ExpandingDotsEffect(
                    dotHeight: 2,
                    dotWidth: 45,
                    activeDotColor: Colors.deepOrange,
                    dotColor: Colors.white24,
                    expansionFactor: 4,
                    spacing: 6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.workouts.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final workout = widget.workouts[index];

              return SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (workout['videoUrl'] != null)
                      SizedBox(
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
              );
            },
          ),
          // Next/Previous buttons
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 20, top: 5),
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
                          backgroundColor:
                              WidgetStateProperty.all<Color>(const Color.fromARGB(255, 117, 117, 117)),
                          padding: WidgetStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(3)),
                          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                        onPressed: _previousWorkout,
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
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.deepOrange),
                          padding: WidgetStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(3)),
                          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                        onPressed: _nextWorkout,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
