import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:terratrack/main/common/constants.dart';
import 'package:terratrack/main/features/home/challenges/screens/chat/chat_screen.dart';
import 'package:terratrack/main/features/home/challenges/widgets/challenges_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String profilePicture = "";
  DateTime? now;
  DateFormat? formatter;
  String? formatted;
  String streaks = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    now = DateTime.now();
    formatter = DateFormat('yyyy-MM-dd');
    formatted = formatter!.format(now!);
    print(formatted);
  }

  int joules = 0;

  getData() async {
    uid = firebaseAuth.currentUser?.uid ?? '';
    var firebaseData = firestore
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      profilePicture = snapshot.get('profilePicture');
      streaks = snapshot.get('streaks');
      setState(() {});
    });
    final prefs = await SharedPreferences.getInstance();
    joules = prefs.getInt("joules")!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: makeDrawer(context),
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: makeAppBar(context),
      ),
      backgroundColor: Colors.lightGreen.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                "EcoElevate",
                style: GoogleFonts.acme(
                  fontSize: 35,
                ),
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            Container(
              margin: const EdgeInsets.only(right: 29),
              width: double.infinity,
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.chat),
                onPressed: () {
                  moveScreen(context, ChatScreen(roomId: "room1"));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(profilePicture),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    children: [
                      Text(
                        "Armaan",
                        style: GoogleFonts.roboto(
                            color: Colors.black, fontSize: 22),
                      ),
                      Text(
                        "${formatted}",
                        style: GoogleFonts.roboto(
                            color: Colors.grey[700], fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 42.0,
                    child: Container(
                      height: 200,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Total Streaks:-\n ${streaks}🔥",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 23,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 12.0,
                    child: Container(
                      height: 200,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Energy Saved:-\n ${joules} Joules",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                '"${appTagline}"',
                style: GoogleFonts.outfit(
                  fontSize: 22,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.only(left: 35),
              alignment: Alignment.centerLeft,
              child: Text(
                "Challenges.",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 27,
                ),
              ),
            ),
            //ugh super bored here
            //yaar, instead of putting everything in one file, let's make moreeeee
            EnergySavingChallengesWidget(),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
