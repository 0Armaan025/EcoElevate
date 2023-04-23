import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:terratrack/main/common/constants.dart';

class StreakScreen extends StatefulWidget {
  final value;
  const StreakScreen({super.key, this.value = "1"});
  @override
  _StreakScreenState createState() => _StreakScreenState();
}

class _StreakScreenState extends State<StreakScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    getData();
  }

  getData() {
    String streaks = "";

    uid = firebaseAuth.currentUser?.uid ?? '';
    var data = firestore
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      streaks = snapshot.get('streaks');
      int streak = int.parse(streaks) + int.parse(widget.value);
      firestore
          .collection('users')
          .doc(uid)
          .update({'streaks': streak.toString()});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purple,
                  Colors.deepPurple,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You got\nanother streak! 🔥🔥',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Congrats! 🥳',
                  style: GoogleFonts.roboto(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 120.0),
            child: CustomPaint(
              painter: FirePainter(_animation),
              size: Size(MediaQuery.of(context).size.width * 0.5,
                  MediaQuery.of(context).size.height * 0.3),
            ),
          ),
        ],
      ),
    );
  }
}

class FirePainter extends CustomPainter {
  final Animation<double> animation;

  FirePainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.orange, Colors.yellow],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.save();

    // Apply a vertical reflection to the canvas to make the fire go upwards
    canvas.translate(size.width / 2, size.height);
    canvas.scale(1, -1);

    final path = Path()
      ..moveTo(0, 0)
      ..cubicTo(
        size.width / 0.6,
        size.height * animation.value * 0.8,
        size.width * 3 / 0.1,
        size.height * animation.value,
        size.width,
        0,
      )
      ..lineTo(size.width, size.height - 10)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(FirePainter oldDelegate) => true;
}
