import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:terratrack/main/common/constants.dart';
import 'package:terratrack/main/features/home/challenges/screens/challenges_screen.dart';

class AddChallengeScreen extends StatefulWidget {
  final String challengeName;
  const AddChallengeScreen({super.key, required this.challengeName});

  @override
  State<AddChallengeScreen> createState() => _AddChallengeScreenState();
}

class _AddChallengeScreenState extends State<AddChallengeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: makeAppBar(context, title: "Let's complete a challenge!"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'Challenge:- ${widget.challengeName}.',
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                width: double.infinity,
                height: 150,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://i0.wp.com/www.glamflame.net/wp-content/uploads/2020/01/Hero-Banner-Placeholder-Light-1024x480-1.png?w=1024&ssl=1'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 18.0, bottom: 8),
                  child: IconButton(
                    icon: Icon(
                      Icons.add_a_photo_outlined,
                      size: 40,
                      color: Colors.white,
                    ),
                    onPressed: () {},
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
