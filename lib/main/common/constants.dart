//firebase
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
    title: Text(title),
    centerTitle: true,
  );
}

File? imageFile;

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
