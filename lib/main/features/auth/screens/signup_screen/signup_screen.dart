import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:terratrack/main/common/constants.dart';
import 'package:terratrack/main/features/auth/controllers/auth_controller.dart';
import 'package:terratrack/main/features/auth/models/user.dart';
import 'package:terratrack/main/features/auth/screens/login_screen/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  Widget makeButton(BuildContext context, String content) {
    return GestureDetector(
      onTap: () {
        signUp(context);
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
          "Sign Up!",
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget makeTextField(
      BuildContext context, String hintText, TextEditingController controller,
      {bool isObscure = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19.0, vertical: 10),
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

  void signUp(BuildContext context) {
    UserModel model = UserModel(
        name: _nameController.text,
        profilePicture: '',
        phoneNumber: _phoneNumberController.text,
        password: _passwordController.text,
        uid: uid,
        email: _emailController.text,
        streaks: '0');

    AuthController().signUp(context, model);
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
                        Text("Let's Sign Up!",
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
                    height: 520,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Stack(
                            children: [
                              imageFile == null
                                  ? CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(
                                          'https://propami.com/assets/corals/images/avatars/avatar_1.png'),
                                    )
                                  : CircleAvatar(
                                      radius: 40,
                                      backgroundImage: FileImage(imageFile!),
                                    ),
                              Positioned(
                                child: IconButton(
                                  onPressed: () {
                                    pickImage(context);
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.yellow,
                                    size: 30,
                                  ),
                                ),
                                left: 40,
                                bottom: -10,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        makeTextField(context, "👲 Please enter your name",
                            _nameController),
                        makeTextField(
                            context,
                            "📱 Please enter your phone number",
                            _phoneNumberController),
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
                              Text("Already a member?\t",
                                  style: GoogleFonts.poppins(
                                    color: Colors.purple,
                                    fontSize: 15,
                                  )),
                              InkWell(
                                onTap: () => moveScreen(context, LoginScreen()),
                                child: Text("Log In Here!",
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
                          height: 10,
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
