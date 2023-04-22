import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:terratrack/main/common/constants.dart';
import 'package:terratrack/main/features/home/challenges/screens/challenges_screen.dart';

class EnergySavingChallengesWidget extends StatefulWidget {
  @override
  _EnergySavingChallengesWidgetState createState() =>
      _EnergySavingChallengesWidgetState();
}

class _EnergySavingChallengesWidgetState
    extends State<EnergySavingChallengesWidget> {
  List<Map<String, dynamic>> challenges = [
    {
      'title': 'Unplug devices when not in use',
      'subtitle': 'Save energy and reduce your bill',
      'instructions': '',
      'icon': Icons.power_off,
      'image':
          'https://5.imimg.com/data5/JS/MK/OG/SELLER-3181704/2-pin-plug-1000x1000.jpg',
      'color': Colors.blue,
      'completed': false,
    },
    {
      'title': 'Use natural light instead of artificial light',
      'subtitle': 'Reduce your energy usage during the day',
      'instructions': '',
      'image':
          'https://images.pexels.com/photos/301599/pexels-photo-301599.jpeg?cs=srgb&dl=pexels-pixabay-301599.jpg&fm=jpg',
      'icon': Icons.wb_sunny,
      'color': Colors.yellow,
      'completed': false,
    },
    {
      'title': 'Wash your clothes in cold water',
      'instructions': '',
      'image':
          'https://www.ikea.com/in/en/images/products/renshacka-clothes-cover-transparent-white__1085564_pe860163_s5.jpg?f=s',
      'subtitle': 'Save energy and reduce your bill',
      'icon': Icons.radio,
      'color': Colors.green,
      'completed': false,
    },
    {
      'title': 'Lower your thermostat by 2 degrees',
      'subtitle': 'Save energy and reduce your bill',
      'instructions': '',
      'image':
          'https://media.istockphoto.com/id/1194920571/photo/smart-thermostat-with-a-person-saving-energy-with-a-soft-shadow.jpg?s=612x612&w=0&k=20&c=EJ1JnujV-T1YYjVEEn3taVc0DsQWhaiAPlybKa6nHCw=',
      'icon': Icons.ac_unit,
      'color': Colors.orange,
      'completed': false,
    },
    {
      'title': 'Cook meals in batches',
      'subtitle': 'Save energy and reduce your bill',
      'instructions': '',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9I4Hk8o1RmPlPTVq_YQzFboDDNxrXiprapiq0R4aj1Z1ubacO_orSf5mNYoOsFRqd2hA&usqp=CAU',
      'icon': Icons.local_dining,
      'color': Colors.red,
      'completed': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 250.0,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          scrollDirection: Axis.horizontal,
          itemCount: challenges.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: 240.0,
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent[100],
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    challenges[index]['icon'],
                    size: 48.0,
                    color: challenges[index]['color'],
                  ),
                  SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      challenges[index]['title'],
                      style: GoogleFonts.poppins(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    challenges[index]['subtitle'],
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        challenges[index]['completed']
                            ? Icons.check_circle_outline
                            : Icons.radio_button_unchecked,
                        size: 16.0,
                        color: challenges[index]['completed']
                            ? Colors.black
                            : Colors.grey,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        challenges[index]['completed']
                            ? 'Completed'
                            : 'Not completed',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: challenges[index]['completed']
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  challenges[index]['completed'] == false
                      ? InkWell(
                          onTap: () {
                            moveScreen(
                              context,
                              ChallengesScreen(
                                challengeName: challenges[index]['title'],
                                challengeInstructions: challenges[index]
                                    ['instructions'],
                                image: challenges[index]['image'],
                              ),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Complete now!",
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : Opacity(opacity: 0, child: Container()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
