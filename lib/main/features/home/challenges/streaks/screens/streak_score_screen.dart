import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:terratrack/main/common/constants.dart';

class StreakScoreScreen extends StatefulWidget {
  const StreakScoreScreen({super.key});

  @override
  State<StreakScoreScreen> createState() => _StreakScoreScreenState();
}

class _StreakScoreScreenState extends State<StreakScoreScreen> {
  String streaks = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

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
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: makeAppBar(context, title: "Your Streak Score"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "Streak Score!",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 32,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Card(
                elevation: 5.0,
                child: Container(
                  height: 300,
                  width: 270,
                  child: Column(
                    children: [
                      Container(
                        width: 300,
                        height: 150,
                        child: Image(
                          image: AssetImage('assets/images/fire.gif'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(38.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "9.2",
                              style: GoogleFonts.poppins(
                                color: Colors.purple,
                                fontSize: 42,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "A perfect\nscore!",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
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
            const SizedBox(
              height: 30,
            ),
            Text(
              "Your Streaks:- \n ${streaks}",
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 32,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
