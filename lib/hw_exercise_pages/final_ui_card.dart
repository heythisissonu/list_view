import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

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

class _WorkoutDetailPageState extends State<WorkoutDetailPage> with SingleTickerProviderStateMixin {
  PageController? _pageController;
  late int _currentIndex;

  // Map to hold the keys for each image to manage reloads
  Map<int, Key> _imageKeys = {};

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    _pageController = PageController(initialPage: _currentIndex);

    // Initialize the keys for each image
    for (int i = 0; i < widget.workouts.length; i++) {
      _imageKeys[i] = UniqueKey();
    }
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

  void _retryImageLoad(int index) {
    setState(() {
      // Generate a new key to force the CachedNetworkImage to reload
      _imageKeys[index] = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
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
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (workout['videoUrl'] != null)
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                            key: _imageKeys[index], // Use the key here
                            imageUrl: workout['videoUrl']!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[800]!,
                              highlightColor: Colors.grey[700]!,
                              child: Container(
                                color: Colors.grey[800],
                                height: double.infinity,
                                width: double.infinity,
                              ),
                            ),
                            errorWidget: (context, url, error) => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.error_outline,
                                  color: Colors.redAccent,
                                  size: 48,
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Failed to load image',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    _retryImageLoad(index);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepOrange,
                                  ),
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
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
          // Navigation Buttons
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 20, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentIndex > 0)
                    AnimatedSize(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: _previousWorkout,
                        child: Container(
                          width: 70,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 117, 117, 117),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            size: 28,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(width: 16),
                  if (_currentIndex < widget.workouts.length - 1)
                    AnimatedSize(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: _nextWorkout,
                        child: Container(
                          width: 70,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            size: 28,
                            color: Colors.white,
                          ),
                        ),
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
