import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final images = <String>['f.png', 'g.png', 't.png'];

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
                const SizedBox(height: 40.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10.0,
                        spreadRadius: 7.0,
                        offset: Offset(1, 1),
                        color: Colors.grey.withOpacity(0.2),
                      )
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Your email',
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.deepOrangeAccent,
                      ),
                      focusedBorder: fgBorder,
                      enabledBorder: fgBorder,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10.0,
                  spreadRadius: 7.0,
                  offset: Offset(1, 1),
                  color: Colors.grey.withOpacity(0.2),
                )
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Your password',
                prefixIcon: const Icon(
                  Icons.password_outlined,
                  color: Colors.deepOrangeAccent,
                ),
                focusedBorder: fgBorder,
                enabledBorder: fgBorder,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40.0),
          Container(
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
                "Sign Up",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40.0),
          Center(
            child: RichText(
              text: const TextSpan(
                text: 'Or sign up using one of the following methods',
                style: TextStyle(fontSize: 17.5, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 30.0),
          Center(
            child: Wrap(
              spacing: 10.0,
              children: List<Widget>.generate(
                3,
                (index) => CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.blueGrey[300],
                  child: CircleAvatar(
                    radius: 27.5,
                    backgroundImage: AssetImage(
                      'assets/images/${images[index]}',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
