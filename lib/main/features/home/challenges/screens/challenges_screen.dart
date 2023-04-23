import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:terratrack/main/common/constants.dart';
import 'package:terratrack/main/features/home/challenges/screens/add_challenge_screen.dart';

class ChallengesScreen extends StatelessWidget {
  final String challengeName;
  final String challengeInstructions;
  final String image;
  const ChallengesScreen(
      {Key? key,
      required this.challengeName,
      required this.challengeInstructions,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '${challengeName}',
          style: GoogleFonts.lato(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Container(
              width: double.infinity,
              height: 250,
              margin: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('${image}'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Challenge:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              challengeName,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Instructions:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              challengeInstructions,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                moveScreen(
                    context, AddChallengeScreen(challengeName: challengeName));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    // color:
                    color: Colors.transparent,
                  ),
                ),
                elevation: 12.0,
                child: Container(
                  height: 50,
                  width: 160,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    // shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Center(
                      child: Text(
                        "Complete Challenge",
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 14,
                        ),
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
  }
}
