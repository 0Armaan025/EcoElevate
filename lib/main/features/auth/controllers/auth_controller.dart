import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:terratrack/main/common/constants.dart';
import 'package:terratrack/main/features/auth/models/user.dart';

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
    });
  }

  void signIn(BuildContext context, String email, String pass) {
    firebaseAuth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((value) {
      print("done");
    });
  }
}
