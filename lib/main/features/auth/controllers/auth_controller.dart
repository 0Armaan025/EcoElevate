import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:terratrack/main/common/constants.dart';
import 'package:terratrack/main/features/auth/models/user.dart';
import 'package:terratrack/main/features/auth/screens/login_screen/login_screen.dart';
import 'package:terratrack/main/features/auth/screens/signup_screen/signup_screen.dart';
import 'package:terratrack/main/features/home/screens/home_screen.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

final String accountSid = 'ACb4cf88e58cb192edd990d56ffc944198';
final String authToken = 'a6c96a11c6bd6c5052d5d499873990c3';
final String fromPhoneNumber = '+17207828068';
TwilioFlutter twilioFlutter = TwilioFlutter(
  accountSid: accountSid, // replace *** with Account SID
  authToken: authToken, // replace xxx with Auth Token
  twilioNumber: fromPhoneNumber, // replace .... with Twilio Number
);
final String message = 'Hello from Flutter!';

class AuthController {
  //sign up lol
  //take the things required for sign up to win lol

  void signUp(BuildContext context, UserModel model) {
    firebaseAuth
        .createUserWithEmailAndPassword(
            email: model.email, password: model.password)
        .then((value) async {
      print("done");
      uid = firebaseAuth.currentUser?.uid ?? '';
      model.uid = uid;

      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference referenceRoot = firebaseStorage.ref();
      Reference referenceDirImages = referenceRoot.child('profilePics');
      Reference refereceImageToUpload =
          referenceDirImages.child(uniqueFileName);
      await refereceImageToUpload.putFile(imageFile!).then((p0) async {
        String downloadUrl = await refereceImageToUpload.getDownloadURL();
        model.profilePicture = downloadUrl;
      });
      firestore.collection('users').doc(uid).set(model.toMap());
      twilioFlutter.sendSMS(
          toNumber: '+91${model.phoneNumber}',
          messageBody:
              'hello ${model.name}, Welcome To EcoElevate, Let\'s be energized! and save energy!');
      moveScreen(context, HomeScreen());
    });
  }

  void signIn(BuildContext context, String email, String pass) {
    firebaseAuth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((value) {
      moveScreen(context, HomeScreen());
    });
  }
}
