// ignore: file_names
import 'package:flutter/material.dart';



class GradientListCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String videoUrl;


  const GradientListCard({
    super.key,    
    required this.title, 
    required this.imageUrl, 
    required this.subtitle, 
    required this.videoUrl,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white, // White stroke
          width: 1, // Stroke width
        ),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)), // Optional rounded corners
      ),
      child: Stack(
        children: [
          // Image inside the container
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(14), bottomLeft: Radius.circular(14)),
            child: Image.network(
              imageUrl, // Use local image path
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
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(14), topLeft: Radius.circular(14)),
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 255, 60, 0).withOpacity(1), // Orange at 100% opacity
                    const Color.fromARGB(255, 255, 81, 0).withOpacity(0), // Orange at 0% opacity
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
                      fontSize: 16,
                      height: 1.1,
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
