import 'package:firebase_getx/auth_controller.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final String email;
  const WelcomeScreen({required this.email, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fgBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: BorderSide(color: Colors.white, width: 1.0),
    );
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            height: screenHeight * 0.3,
            width: screenWidth,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/signup.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.175),
                const CircleAvatar(
                  backgroundColor: Colors.white70,
                  radius: 52.5,
                  backgroundImage: AssetImage('assets/images/profile1.png'),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            width: screenWidth,
            // screen width must be written so crossAxisAlignment have effects
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 55.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  email,
                  style: TextStyle(fontSize: 20, color: Colors.grey[500]),
                ),
                const SizedBox(height: 150.0),
                GestureDetector(
                  onTap: () {
                    AuthController.instance.logout();
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 60.0),
                    height: screenHeight * 0.08,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/loginbtn.png'),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Sign Out",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
