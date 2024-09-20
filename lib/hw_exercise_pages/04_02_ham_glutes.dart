import 'package:flutter/material.dart';
import 'package:list_view/hw_exercise_pages/ui_card_design.dart';
import 'exercises_data.dart';
import 'final_ui_card.dart';

class UpperBodyPageHam extends StatefulWidget {
  final String title;
  final String description;

  // ignore: prefer_const_constructors_in_immutables
  UpperBodyPageHam({super.key, required this.title, required this.description});


 @override
  // ignore: library_private_types_in_public_api
  _UpperBodyPageHamState createState() => _UpperBodyPageHamState();
}

class _UpperBodyPageHamState extends State<UpperBodyPageHam> {
  // Track which item is expanded
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF151515), // Body background color
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.deepOrange),
        ),
        backgroundColor: const Color.fromARGB(255, 22, 22, 22),
        foregroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: hamstringsAndGlutesExercises.length,
          itemBuilder: (context, index) {
            final data = hamstringsAndGlutesExercises[index];
            final bool isExpanded = _expandedIndex == index;

            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: InkWell(
                // Ripple effect on tap
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WorkoutDetailPage(
                        workouts: hamstringsAndGlutesExercises,
                        currentIndex: index,
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            const Color.fromARGB(255, 230, 63, 12).withOpacity(1.0), // DeepOrange with 100% opacity
                            const Color.fromARGB(255, 29, 29, 29).withOpacity(0.1),  // Black with 10% opacity
                          ],
                        ),
                        border: Border.all(color: Colors.deepOrange, width: 1),
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GradientListCard(
                            imageUrl: data["imageUrl"]!,
                            title: data["title"]!,
                            subtitle: '',
                            videoUrl: '',
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 18),
                                Text(
                                  data["title"]!,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepOrange,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                const SizedBox(height: 1),
                                Text(
                                  data["subtitle"]!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white70,
                                    height: 1.0, // Line height - reduces the space between lines
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                const SizedBox(height: 18),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (_expandedIndex == index) {
                                        _expandedIndex = null;
                                      } else {
                                        _expandedIndex = index;
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          data["description"]!,
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14,
                                            height: 1.1,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis, // Truncates if exceeds 2 lines
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Icon(
                                          Icons.arrow_right,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 160),
                        curve: Curves.easeOut,
                        height: isExpanded ? 100 : 0, // Adjust the height as needed
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color.fromARGB(186, 100, 33, 10).withOpacity(1), // Orange at 100% opacity
                              const Color.fromARGB(255, 27, 27, 27).withOpacity(1), // Orange at 0% opacity
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ), // Rounded corners
                        ),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 2, left: 5, right: 5, bottom: 3),
                            child: Text(
                              data["description"]!,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 172, 172, 172),
                                fontSize: 14,
                                height: 1.1, // Reduce space between lines
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
