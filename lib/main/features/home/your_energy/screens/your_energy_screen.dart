import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:terratrack/main/common/constants.dart';
// import 'package:url_launcher/';
import 'package:url_launcher/url_launcher.dart';

class YourEnergyScreen extends StatefulWidget {
  const YourEnergyScreen({super.key});

  @override
  State<YourEnergyScreen> createState() => YourEnergyScreenState();
}

class YourEnergyScreenState extends State<YourEnergyScreen> {
  Uri? selectedUrl;

  Uri chooseSomething() {
    final Random random = Random();

    final int randomNumber = random.nextInt(4);
    switch (randomNumber) {
      case 0:
        selectedUrl = Uri.parse('https://www.youtube.com/watch?v=g7lOV17OI4s');
        break;
      case 1:
        selectedUrl = Uri.parse('https://www.youtube.com/watch?v=EeQ6YzUHvE4&');
        break;
      case 2:
        selectedUrl = Uri.parse('https://youtu.be/RdRr8qqtXAo');
        break;
      case 3:
        selectedUrl = Uri.parse('https://www.chess.com/');
        break;
    }
    return selectedUrl!;
  }

  openLauncher() async {
    chooseSomething();
    await launchUrl(selectedUrl!);
    setState(() {});
    chooseSomething();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  String streaks = "";

  getData() {
    uid = firebaseAuth.currentUser?.uid ?? '';
    var data = firestore
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      streaks = snapshot.get('streaks');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent.shade100,
      appBar: PreferredSize(
        child: makeAppBar(context),
        preferredSize: Size(double.infinity, kToolbarHeight),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "Let's get you energized!",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 28,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "You have ${streaks} streaks 🔥",
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 26,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  openLauncher();
                },
                child: Container(
                  height: 30,
                  width: 160,
                  alignment: Alignment.center,
                  child: Text(
                    "Get energized / ${streaks}!",
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Text(
                  "The energy of a hacker refers to their physical and mental capacity to perform tasks and engage in activities. This energy is influenced by a variety of factors, including sleep quality, diet, exercise, stress levels, and overall health. When a person has high energy, they are generally able to perform tasks efficiently and with enthusiasm, and they are less likely to feel fatigued or sluggish throughout the day.",
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
