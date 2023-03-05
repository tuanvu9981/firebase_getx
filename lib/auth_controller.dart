import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_getx/screens/login_screen.dart';
import 'package:firebase_getx/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // an instance of AuthController
  static AuthController instance = Get.find();

  // username, password, ... of user
  late Rx<User?> user;

  // instance of firebase auth
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    user = auth.currentUser as Rx<User?>;

    // notify user
    user.bindStream(auth.userChanges());

    // lister. called each time "user" changes
    ever(user, _initializeScreen);
  }

  _initializeScreen(User? user) {
    if (user == null) {
      Get.offAll(const LoginScreen());
    } else {
      Get.offAll(WelcomeScreen(email: user.email!));
    }
  }

  void register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      Get.snackbar(
        "About user",
        "User message",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          "Account created failed!",
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(
          e.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      );
    }
  }

  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar(
        "About login",
        "Login message",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          "Login failed!",
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(
          e.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      );
    }
  }

  void logout() async {
    await auth.signOut();
  }
}
