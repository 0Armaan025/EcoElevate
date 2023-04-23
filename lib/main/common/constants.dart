//firebase
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:terratrack/main/features/home/challenges/screens/save_energy_screen.dart';

//firebase vars
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

//some other constants

String appName = "EcoElevate";
String appTagline = "Small steps, big impact.";

Widget makeAppBar(BuildContext context, {String title = "EcoElevate"}) {
  return AppBar(
    backgroundColor: Colors.green,
    title: Text(
      title,
      style: GoogleFonts.raleway(
        fontWeight: FontWeight.w500,
      ),
    ),
    centerTitle: true,
  );
}

File? imageFile;
String uid = "";

void pickImage(BuildContext context) async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  imageFile = File(image!.path);
}

void moveScreen(BuildContext context, Widget screen,
    {bool isPushReplacement = false}) {
  if (isPushReplacement == true) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => screen));
  } else {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
  }
}

showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

String theGlobalProfilePicture = "";

Widget makeDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text("Armaan"),
          accountEmail: Text("armaan33000@gmail.com"),
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage("${theGlobalProfilePicture}"),
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Colors.green,
                Colors.lightBlueAccent,
              ],
            ),
          ),
        ),
        ListTile(
          tileColor: Colors.lightGreen,
          leading: Icon(Icons.home),
          title: Text(
            "Home",
            style: GoogleFonts.rubik(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          onTap: () {},
        ),
        Divider(
          height: 1,
          thickness: 5,
          color: Colors.transparent,
        ),
        ListTile(
          tileColor: Colors.lightGreen,
          leading: Icon(Icons.settings),
          title: Text(
            "Save Energy",
            style: GoogleFonts.rubik(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          onTap: () {
            moveScreen(context, SaveEnergyScreen());
          },
        ),
        Divider(
          thickness: 5,
          height: 1,
          color: Colors.transparent,
        ),
        ListTile(
          tileColor: Colors.lightGreen,
          leading: Icon(Icons.settings),
          title: Text(
            "Your Energy?",
            style: GoogleFonts.rubik(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          onTap: () {},
        ),
        Divider(
          thickness: 5,
          height: 1,
          color: Colors.transparent,
        ),
        ListTile(
          tileColor: Colors.lightGreen,
          leading: Icon(Icons.settings),
          title: Text(
            "Streaks Time",
            style: GoogleFonts.rubik(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          onTap: () {},
        ),
        Divider(
          thickness: 5,
          height: 10,
          color: Colors.transparent,
        ),
        ListTile(
          tileColor: Colors.lightGreen[300],
          leading: Icon(Icons.settings),
          title: Text(
            "Settings",
            style: GoogleFonts.rubik(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          onTap: () {},
        ),
        Divider(
          height: 1,
          thickness: 5,
          color: Colors.transparent,
        ),
        ListTile(
          tileColor: Colors.lightGreen[400],
          leading: Icon(Icons.logout),
          title: Text(
            "Log Out",
            style: GoogleFonts.rubik(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          onTap: () {},
        ),
      ],
    ),
  );
}
