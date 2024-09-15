import 'package:flutter/material.dart';

class GradientImageCard extends StatelessWidget {
  final String imagePath;
  final String title;

  const GradientImageCard({
    super.key,
    required this.imagePath,
    required this.title,
  });

  // List of card data
  static const List<Map<String, String>> cardData = [
    {
      "imagePath": "lib/images/body/01-fullbody.webp", // Local image path
      "title": "Full Body"
    },
    {
      "imagePath": "lib/images/body/02-upperbody.webp", // Local image path
      "title": "Upper Body"
    },
    {
      "imagePath": "lib/images/body/03-middlebody.webp", // Local image path
      "title": "Middle Body"
    },
    {
      "imagePath": "lib/images/body/04-lowerbody.webp", // Local image path
      "title": "Lower Body"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 250,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white, // White stroke
          width: 2, // Stroke width
        ),
        borderRadius: BorderRadius.circular(18), // Optional rounded corners
      ),
      child: Stack(
        children: [
          // Image inside the container
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              imagePath, // Use local image path
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover, // Cover entire container
            ),
          ),
          // Gradient and text stacked at the bottom of the image
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 100, // Adjust height of the gradient
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 255, 60, 0).withOpacity(1), // Orange at 100% opacity
                    const Color.fromARGB(255, 255, 102, 0).withOpacity(0), // Orange at 0% opacity
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    title, // Use dynamic title
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
