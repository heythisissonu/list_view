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

class _WorkoutDetailPageState extends State<WorkoutDetailPage> {
  PageController? _pageController;
  late int _currentIndex;
  bool isExpanded = false; // State to toggle description expansion

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  void _toggleDescription() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void _nextWorkout() {
    if (_currentIndex < widget.workouts.length - 1) {
      _pageController?.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousWorkout() {
    if (_currentIndex > 0) {
      _pageController?.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
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
                    (widget.workouts[_currentIndex]['title']?.length ?? 0) > 20 
                      ? '${widget.workouts[_currentIndex]['title']!.substring(0, 20)}...' 
                      : widget.workouts[_currentIndex]['title'] ?? 'Workout Detail',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
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
                padding: const EdgeInsets.only(
                bottom: 16, left: 16, right: 16, top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (workout['imageUrl'] != null) //instead of videoUrl, currently using ImageURL, cause both contains same URLs
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: CachedNetworkImage(
                            imageUrl: workout['imageUrl']!, //instead of videoUrl, currently using ImageURL, cause both contains same URLs
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
                            errorWidget: (context, url, error) => Image.asset(
                              'lib/images/body/no_internet.webp',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 10),
                    Stack(
                      children: [
                        // Outer container for gradient border
                        Container(
                          padding: const EdgeInsets.all(1), // Space for the gradient border
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Colors.deepOrangeAccent,
                                Color.fromARGB(174, 15, 15, 15),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 15, 15, 15), // Inner container background
                              borderRadius: BorderRadius.circular(16),                              
                            ),
                            child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(117, 129, 35, 7),
                                Color.fromARGB(255, 15, 15, 15),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                            
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  workout['title'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    height: 0.90,
                                    color: Colors.white,                                    
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  workout['subtitle'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    height: 0.90,
                                    color: Color.fromARGB(209, 255, 255, 255),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                GestureDetector(
                                  onTap: _toggleDescription,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      AnimatedCrossFade(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        firstChild: Text(
                                          workout['description'] ?? '',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white70,
                                            height: 1.1,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        secondChild: Text(
                                          workout['description'] ?? '',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white70,
                                            height: 1.1,
                                          ),
                                        ),
                                        crossFadeState: isExpanded
                                            ? CrossFadeState.showSecond
                                            : CrossFadeState.showFirst,
                                      ),                                      
                                         Text(
                                          isExpanded ? 'see less...' : 'see more...',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.deepOrangeAccent,
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
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
