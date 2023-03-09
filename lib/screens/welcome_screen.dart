import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_getx/auth_controller.dart';
import 'package:firebase_getx/models/car.model.dart';
import 'package:firebase_getx/models/fsuser.model.dart';
import 'package:firebase_getx/widgets/car_card.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class WelcomeScreen extends StatefulWidget {
  final String uid;
  const WelcomeScreen({required this.uid, Key? key}) : super(key: key);

  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  // instance collection
  final fsUsers = FirebaseFirestore.instance.collection('users');
  final fsCars = FirebaseFirestore.instance.collection('cars');

  // instance storage
  final storageAvatarRef = FirebaseStorage.instance.ref().child('avatars/');
  final storageImgRef = FirebaseStorage.instance.ref().child('images/');

  // variables to display
  FSUser? fsUser;
  List<Car?> cars = [];

  // get image from smart phone
  XFile? newAvatar;
  XFile? newCarImg;
  final picker = ImagePicker();

  // text controller for input
  var makerEditor = TextEditingController();
  var licenseIdEditor = TextEditingController();

  Future<void> _uploadImage(ImageSource source, String uid) async {
    // select file (from gallery | from camera)
    XFile? img = await picker.pickImage(source: source);

    // upload file to storage "avatars"
    UploadTask uploadTask =
        storageAvatarRef.child(img!.name).putFile(File(img.path));

    // get downloadUrl from storage (UploadTask extends Future<TaskSnapshot>)
    final location = await (await uploadTask).ref.getDownloadURL();

    // update user data --> data changes --> widget re-render
    final snapShot = await fsUsers.where('uid', isEqualTo: uid).get();
    DocumentReference docRef = snapShot.docs[0].reference;

    var batch = FirebaseFirestore.instance.batch();
    //Updates the field value, using "docRef" as document reference
    batch.update(docRef, {'imageUrl': location});
    batch.commit();

    await _getUserByUId(uid);
  }

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

  Future<void> _setCarImgUrl(ImageSource source) async {
    XFile? img = await picker.pickImage(source: source);
    setState(() {
      newCarImg = img;
    });
  }

  Future<void> _addNewCar(
    String uid,
    String maker,
    String licenseId,
    XFile? image,
  ) async {
    // upload file to storage "images"
    UploadTask uploadTask =
        storageImgRef.child(image!.name).putFile(File(image.path));

    // get downloadUrl from storage (UploadTask extends Future<TaskSnapshot>)
    final location = await (await uploadTask).ref.getDownloadURL();

    // create firestore documents car
    final newCar = Car(
      maker: maker,
      licenseId: licenseId,
      userId: uid,
      imageUrl: location,
    );
    await fsCars.add(newCar.toJson());
    await _getCarsOfUser(uid);
    setState(() {
      newCarImg = null;
    });
  }

  Future<void> _create(XFile? newCarImg, BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              newCarImg == null
                  ? GestureDetector(
                      onTap: () {
                        _setCarImgUrl(ImageSource.gallery);
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 0.5),
                        ),
                        child: const Icon(Icons.add, size: 30.0),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        _setCarImgUrl(ImageSource.gallery);
                      },
                      child: Image.file(
                        File(newCarImg.path),
                        fit: BoxFit.cover,
                        width: 100.0,
                        height: 80.0,
                      ),
                    ),
              const SizedBox(height: 20.0),
              TextField(
                controller: makerEditor,
                decoration: InputDecoration(
                  labelText: 'Maker',
                  prefixIcon: Icon(
                    Icons.precision_manufacturing_outlined,
                    size: 27.5,
                    color: Colors.orange[300],
                  ),
                ),
              ),
              TextField(
                controller: licenseIdEditor,
                decoration: InputDecoration(
                  labelText: 'License Id',
                  prefixIcon: Icon(
                    Icons.app_registration_rounded,
                    size: 27.5,
                    color: Colors.orange[300],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _addNewCar(
                    widget.uid,
                    makerEditor.text.trim(),
                    licenseIdEditor.text.trim(),
                    newCarImg,
                  );
                  Navigator.pop(context);
                },
                child: Text('Create'),
              ),
            ],
          ),
        );
      },
    );
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
                      onTap: () {
                        _uploadImage(ImageSource.gallery, widget.uid);
                      },
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
        onPressed: () {
          _create(newCarImg, context);
        },
        backgroundColor: Colors.amber[200],
        child: const Icon(Icons.add, size: 30.0, color: Colors.white),
      ),
    );
  }
}
