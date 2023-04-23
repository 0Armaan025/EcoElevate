import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:terratrack/main/common/constants.dart';
import 'package:terratrack/main/features/auth/controllers/auth_controller.dart';

import 'package:terratrack/main/features/auth/screens/signup_screen/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Widget makeButton(BuildContext context, String content) {
    return GestureDetector(
      onTap: () async {
        login(context);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 60),
        width: 270,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.lightBlue.shade200,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          "Log In!",
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) {
    AuthController()
        .signIn(context, _emailController.text, _passwordController.text);
  }

  Widget makeTextField(
      BuildContext context, String hintText, TextEditingController controller,
      {bool isObscure = false}) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blue),
          ),
        ),
        obscureText: isObscure,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: makeAppBar(context),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        AssetImage('assets/images/carbon_footprint.png'),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text("Let's Log In!",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 29,
                            )),
                        Text("${appTagline}",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 18,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Center(
                child: Card(
                  elevation: 2.0,
                  child: Container(
                    height: 320,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: Column(
                      children: [
                        makeTextField(context, "✉️ Please enter your email",
                            _emailController),
                        makeTextField(context, "🔑 Please enter your password",
                            _passwordController,
                            isObscure: true),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("New to EcoElevate?\t",
                                  style: GoogleFonts.poppins(
                                    color: Colors.purple,
                                    fontSize: 15,
                                  )),
                              InkWell(
                                onTap: () {
                                  moveScreen(context, SignUpScreen());
                                },
                                child: Text("Sign Up Here!",
                                    style: GoogleFonts.poppins(
                                      color: Colors.purple,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    )),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        makeButton(context, "Log In!"),
                      ],
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
