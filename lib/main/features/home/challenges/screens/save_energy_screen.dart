import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:terratrack/main/common/constants.dart';
import 'package:terratrack/main/features/home/challenges/streaks/screens/streak_screen.dart';

class SaveEnergyScreen extends StatefulWidget {
  const SaveEnergyScreen({super.key});

  @override
  State<SaveEnergyScreen> createState() => _SaveEnergyScreenState();
}

class _SaveEnergyScreenState extends State<SaveEnergyScreen> {
  DateTime? now;
  DateFormat? formatter;
  String? formatted;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    now = DateTime.now();
    formatter = DateFormat('yyyy-MM-dd');
    formatted = formatter!.format(now!);
  }

  @override
  Widget build(BuildContext context) {
    final _usageController = TextEditingController();

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
                'Let\'s calculate the Energy used for ${formatted} in joules!',
                style: GoogleFonts.adamina(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 38.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        height: 120,
                        child: TextField(
                          controller: _usageController,
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 49,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 100, horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          maxLength: 6,
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
            Center(
              child: InkWell(
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  bool done = false;

                  if (prefs.containsKey("usage")) {
                    int data = prefs.getInt("usage")!;

                    try {
                      if (data >
                          (int.parse(_usageController.text.toString()))) {
                        showSnackBar(context,
                            "Yes, you saved energy! Congrats! You got 10 more streaks! 🥳🔥");
                        String streaks = "";

                        uid = firebaseAuth.currentUser?.uid ?? '';
                        final docRef = firestore.collection('users').doc(uid);
                        docRef.get().then((DocumentSnapshot snapshot) {
                          streaks = snapshot.get('streaks');
                          setState(() {});
                        });
                        moveScreen(context, StreakScreen(value: "5"));

                        prefs.setInt("usage",
                            int.parse(_usageController.text.toString()));
                      } else {
                        showSnackBar(context,
                            "Sadly, you didn't save much energy today :(, please refer to challenges!");
                        prefs.setInt("usage",
                            int.parse(_usageController.text.toString()));
                      }
                    } catch (e) {
                      print("Error parsing data: $data");
                      showSnackBar(context, "Error: Invalid data format");
                    }
                  } else {
                    showSnackBar(context,
                        "There were no past records, so new record has been added!");

                    prefs.setInt(
                        "usage", int.parse(_usageController.text.toString()));
                  }
                },
                child: Container(
                  width: 170,
                  height: 50,
                  child: Text(
                    "Calculate!",
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                      ),
                      color: Colors.lightGreen[200]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
