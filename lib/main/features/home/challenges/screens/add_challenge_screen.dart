import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:terratrack/main/common/constants.dart';
import 'package:terratrack/main/features/home/challenges/models/challenge.dart';
import 'package:terratrack/main/features/home/challenges/screens/challenges_screen.dart';
import 'package:terratrack/main/features/home/challenges/streaks/screens/streak_screen.dart';
import 'package:terratrack/main/features/home/screens/home_screen.dart';
import 'package:video_player/video_player.dart';

class AddChallengeScreen extends StatefulWidget {
  final String challengeName;
  const AddChallengeScreen({super.key, required this.challengeName});

  @override
  State<AddChallengeScreen> createState() => _AddChallengeScreenState();
}

class _AddChallengeScreenState extends State<AddChallengeScreen> {
  File? videoFile;
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  String myUid = "";
  String profilePicture = "";
  String myName = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );
    _controller.setVolume(1);

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    getData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    
  }

  void getData() {
    myUid = firebaseAuth.currentUser?.uid ?? '';

    var firebaseData = firestore
        .collection('users')
        .doc(myUid)
        .get()
        .then((DocumentSnapshot snapshot) {
      myName = snapshot.get('name');
      profilePicture = snapshot.get('profilePicture');
      setState(() {});
    });
  }

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
                    onPressed: () async {
                      final ImagePicker _picker = ImagePicker();
                      final XFile? video =
                          await _picker.pickVideo(source: ImageSource.gallery);
                      videoFile = File(video!.path);
                      _controller = VideoPlayerController.file(videoFile!);
                      _controller.addListener(() {
                        setState(() {});
                      });
                      _controller.setLooping(true);
                      _controller.initialize().then((_) => setState(() {}));
                      _controller.play();
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38.0),
              child: AspectRatio(
                aspectRatio: 1,
                // Use the VideoPlayer widget to display the video.
                child: VideoPlayer(_controller),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: GestureDetector(
                onTap: () async {
                  ChallengeModel model = ChallengeModel(
                    challengeName: widget.challengeName,
                    videoUrl: '',
                    uid: uid,
                    userName: myName,
                    userProfilePicture: profilePicture,
                  );

                  String fileName =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  Reference storageRef =
                      FirebaseStorage.instance.ref().child('videos/$fileName');
                  TaskSnapshot taskSnapshot =
                      await storageRef.putFile(videoFile!);
                  String downloadURL = await storageRef.getDownloadURL();
                  model.videoUrl = downloadURL;
                  firestore
                      .collection('challenges')
                      .doc(uid + widget.challengeName)
                      .set(model.toMap())
                      .then((value) {
                    moveScreen(context, StreakScreen(),
                        isPushReplacement: true);
                  });
                },
                child: Container(
                  height: 50,
                  width: 240,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Submit Challenge 🔥",
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 18,
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
