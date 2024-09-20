import 'package:flutter/material.dart';
import 'package:list_view/LowerBodySubcategoryPage.dart';
import 'package:list_view/UpperBodySubcategoryPage.dart';
import 'package:list_view/hw_exercise_pages/03_coreworkout.dart';
import 'package:list_view/hw_exercise_pages/01_fullbody.dart';
import 'ui_imagecard.dart';
import 'homeworkout_detailed_page.dart';

void main() {
  runApp(
    const MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false, // Optional: Hide the debug banner
    ),
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pavanputra - Fitness App',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'One stop solution for all your fitness needs. We help you achieve your fitness goals.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),

                ///////////////////////////////////////Copy from here
              
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(thickness: 1, color: Colors.deepOrange),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Home Workout',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'A fitness routine performed at home using minimal equipment, relying on body-weight exercises or basic gear.',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) =>
                                const HomeWorkoutDetailedPage(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;

                              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                              var offsetAnimation = animation.drive(tween);

                              return SlideTransition(position: offsetAnimation, child: child);
                            },
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.deepOrange,
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Displaying the GradientImageCards from cardData
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: GradientImageCard.cardData.map((data) {
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Widget page;
                              switch (data["title"]) {
                                case "Full Body":
                                  page = FullBodyPage(title: data["title"]!, description: data["description"]!);
                                  break;
                                case "Upper Body":
                                  page = const Upperbodysubcategorypage();
                                  break;
                                case "Core Workout":
                                  page = CoreWorkoutPage(title: data["title"]!, description: data["description"]!);
                                  break;
                                case "Lower Body":
                                  page = const LowerBodySubcategoryPage();
                                  break;
                                default:
                                  return;
                              }

                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => page,
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    const begin = Offset(1.0, 0.0);
                                    const end = Offset.zero;
                                    const curve = Curves.easeInOut;

                                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                    var offsetAnimation = animation.drive(tween);

                                    return SlideTransition(position: offsetAnimation, child: child);
                                  },
                                ),
                              );
                            },
                            child: GradientImageCard(
                              imagePath: data["imagePath"]!,
                              title: data["title"]!,
                            ),
                          ),
                          const SizedBox(width: 16),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Divider(thickness: 1, color: Colors.deepOrange),
                ),
                ////////////////////////////////Till Here  
              ],
            ),
          ),
        ),
      ),
    );
  }
}
