import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_getx/models/fsuser.model.dart';
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

  // instances of firebase firestore
  late CollectionReference cars;
  late CollectionReference fsUsers;

  final String defaultAvatar =
      'https://firebasestorage.googleapis.com/v0/b/fir-getx-flutter-bd7d8.appspot.com/o/default_user.jpg?alt=media&token=b24066c2-0b5b-480a-9a54-fd307d1078f1';

  @override
  void onReady() {
    super.onReady();

    // init late storage collection
    cars = FirebaseFirestore.instance.collection('cars');
    fsUsers = FirebaseFirestore.instance.collection('users');

    // init late user
    user = Rx<User?>(auth.currentUser);

    // notify user
    user.bindStream(auth.userChanges());

    // lister. called each time "user" changes
    ever(user, _initializeScreen);
  }

  _initializeScreen(User? user) {
    if (user == null) {
      Get.offAll(const LoginScreen());
    } else {
      Get.offAll(WelcomeScreen(uid: user.uid));
    }
  }

  void register(String email, String password, String fullname) async {
    try {
      UserCredential newUser = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final newFsUser = FSUser(
        uid: newUser.user?.uid,
        fullname: fullname,
        email: newUser.user?.email,
        imageUrl: defaultAvatar,
      );

      await fsUsers.add(newFsUser.toJson());
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
