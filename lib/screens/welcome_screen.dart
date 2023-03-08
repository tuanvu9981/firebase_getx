import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_getx/auth_controller.dart';
import 'package:firebase_getx/models/car.model.dart';
import 'package:firebase_getx/models/fsuser.model.dart';
import 'package:firebase_getx/widgets/car_card.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  final String uid;
  const WelcomeScreen({required this.uid, Key? key}) : super(key: key);

  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  final fsUsers = FirebaseFirestore.instance.collection('users');
  final fsCars = FirebaseFirestore.instance.collection('cars');
  FSUser? fsUser;
  List<Car?> cars = [];

  Future<void> _getUserByUId(String uid) async {
    final snapShot = await fsUsers.where('uid', isEqualTo: uid).get();
    List<Map<String, dynamic>?> data =
        snapShot.docs.map((e) => e.data()).toList();
    setState(() {
      fsUser = FSUser.fromJson(data[0]!);
    });
  }

  Future<void> _getCarsOfUser(String uid) async {
    final snapShots = await fsCars.where('userId', isEqualTo: uid).get();
    List<Map<String, dynamic>?> data =
        snapShots.docs.map((e) => e.data()).toList();
    List<Car?> carsData = data.map((e) => Car.fromJson(e!)).toList();
    setState(() {
      cars = carsData;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserByUId(widget.uid);
    _getCarsOfUser(widget.uid);
  }

  List<Widget> _buildCarList(List<Car?> cars) {
    return cars.map((e) => CarCard(car: e)).toList();
  }

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
                Container(
                  padding: const EdgeInsets.all(15.0),
                  width: screenWidth,
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      AuthController.instance.logout();
                    },
                    child: const Text(
                      "Sign out",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.1),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white24,
                      radius: 52.5,
                      backgroundImage: NetworkImage(fsUser?.imageUrl ?? ""),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 0.25),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 22.5,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            width: screenWidth,
            // screen width must be written so crossAxisAlignment have effects
            child: Center(
              child: Column(
                children: [
                  Text(
                    fsUser?.fullname ?? "",
                    style: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    fsUser?.email ?? "",
                    style: TextStyle(fontSize: 17, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "My car list",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Colors.black,
                  ),
                ),
                ..._buildCarList(cars),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.amber[200],
        child: const Icon(Icons.add, size: 30.0, color: Colors.white),
      ),
    );
  }
}
