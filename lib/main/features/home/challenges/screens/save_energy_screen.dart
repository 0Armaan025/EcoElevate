import 'package:flutter/material.dart';
import 'package:terratrack/main/common/constants.dart';

class SaveEnergyScreen extends StatefulWidget {
  const SaveEnergyScreen({super.key});

  @override
  State<SaveEnergyScreen> createState() => _SaveEnergyScreenState();
}

class _SaveEnergyScreenState extends State<SaveEnergyScreen> {
  @override
  Widget build(BuildContext context) {
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
          ],
        ),
      ),
    );
  }
}
