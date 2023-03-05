import 'package:firebase_getx/auth_controller.dart';
import 'package:firebase_getx/screens/signup_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  var emailEditor = TextEditingController();
  var passwordEditor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var fgBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: BorderSide(color: Colors.white, width: 1.0),
    );

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: ListView(
            children: [
              Container(
                height: screenH * 0.3,
                width: screenW,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/loginimg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                width: screenW,
                // screen width must be written so crossAxisAlignment have effects
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hello",
                      style: TextStyle(
                        fontSize: 55.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Sign in to your account",
                      style: TextStyle(fontSize: 20, color: Colors.grey[500]),
                    ),
                    const SizedBox(height: 50.0),
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
                        controller: emailEditor,
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
                  controller: passwordEditor,
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
              const SizedBox(height: 20.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                width: screenW,
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot your password ?",
                  style: TextStyle(fontSize: 20, color: Colors.grey[500]),
                ),
              ),
              const SizedBox(height: 40.0),
              GestureDetector(
                onTap: () {
                  AuthController.instance.login(
                    emailEditor.text.trim(),
                    passwordEditor.text.trim(),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 60.0),
                  height: screenH * 0.08,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/loginbtn.png'),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40.0),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Dont have an account ? ',
                    style: TextStyle(fontSize: 20.0, color: Colors.grey),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.to(const SignUpScreen()),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
