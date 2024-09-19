import 'package:flutter/material.dart';
import 'package:list_view/upperbody_data.dart';
import 'package:list_view/hw_exercise_pages/02_01_back.dart';
import 'package:list_view/hw_exercise_pages/02_02_chest.dart';
import 'package:list_view/hw_exercise_pages/02_03_shoulders.dart';
import 'package:list_view/hw_exercise_pages/02_04_biceps.dart';
import 'package:list_view/hw_exercise_pages/02_05_triceps.dart';

class Upperbodysubcategorypage extends StatelessWidget {
  const Upperbodysubcategorypage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF151515), // Body background color
      appBar: AppBar(
        title: const Text(
          'Home Workout Guide',
          style: TextStyle(color: Colors.deepOrange),
        ),
        backgroundColor: const Color.fromARGB(255, 22, 22, 22),
        foregroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: upperBodyData.length,
          itemBuilder: (context, index) {
            final data = upperBodyData[index];

            return GestureDetector(
              onTap: () {
                // Handle navigation based on the title
                if (data["title"] == "Chest") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpperBodyPageChest(
                        title: data["title"]!,
                        description: data["description"]!,
                      ),
                    ),
                  );
                } else if (data["title"] == "Back") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpperBodyPageBack(
                        title: data["title"]!,
                        description: data["description"]!,
                      ),
                    ),
                  );
                } else if (data["title"] == "Shoulders") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpperBodyPageShoulders(
                        title: data["title"]!,
                        description: data["description"]!,
                      ),
                    ),
                  );
                } else if (data["title"] == "Biceps") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpperBodyPageBiceps(
                        title: data["title"]!,
                        description: data["description"]!,
                      ),
                    ),
                  );
                } else if (data["title"] == "Triceps") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpperBodyPageTriceps(
                        title: data["title"]!,
                        description: data["description"]!,
                      ),
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        const Color.fromARGB(255, 230, 63, 12).withOpacity(1.0), // DeepOrange with 100% opacity
                        const Color.fromARGB(255, 77, 28, 0).withOpacity(0.1),  // Black with 10% opacity
                      ],
                    ),
                    border: Border.all(color: Colors.deepOrange, width: 1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomeWorkoutCard(
                        imagePath: data["imagePath"]!,
                        title: data["title"]!,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              data["title"]!,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrange,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Padding(
                              padding: const EdgeInsets.only(right: 10, top: 5),
                              child: Text(
                                data["description"]!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                  height: 1.0, // Line height - reduces the space between lines
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class HomeWorkoutCard extends StatelessWidget {
  final String imagePath;
  final String title;

  const HomeWorkoutCard({super.key, required this.imagePath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(14), topLeft: Radius.circular(14)),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      width: 120,
      height: 150,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              //bottomRight: Radius.circular(16),
            ),
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
