import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:terratrack/main/common/constants.dart';
import 'package:terratrack/main/features/auth/screens/login_screen/login_screen.dart';
import 'package:terratrack/main/features/home/screens/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  String uid = "";

  @override
  void initState() {
    super.initState();
    uid = firebaseAuth.currentUser?.uid ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              OnboardingPage(
                title: "Save Energy",
                description:
                    "Monitor your energy usage and get suggestions for reducing it",
                image: "assets/images/energy_usage.png",
              ),
              OnboardingPage(
                title: "Reduce Waste",
                description:
                    "Track your waste production and get tips on how to reduce it",
                image: "assets/images/waste_reduction.png",
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: GestureDetector(
              onTap: () {
                if (_pageController.page!.toInt() == 1) {
                  print("it is");

                  if (firebaseAuth.currentUser == null) {
                    moveScreen(
                        context, isPushReplacement: true, const LoginScreen());
                  } else {
                    moveScreen(
                        context, isPushReplacement: true, const HomeScreen());
                  }
                } else {
                  _pageController.animateToPage(
                    _pageController.page!.toInt() + 1,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
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

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 80),
        Image.asset(
          image,
          height: 200,
        ),
        SizedBox(height: 60),
        Text(
          title,
          style: TextStyle(
            color: Colors.green,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            description,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
