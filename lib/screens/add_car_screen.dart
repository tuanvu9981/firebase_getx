import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/car.model.dart';

class AddCarScreen extends StatefulWidget {
  String uid;
  AddCarScreen({required this.uid, Key? key}) : super(key: key);

  @override
  AddCarScreenState createState() => AddCarScreenState();
}

class AddCarScreenState extends State<AddCarScreen> {
  XFile? newCarImg;
  final picker = ImagePicker();

  // text controller for input
  var makerEditor = TextEditingController();
  var licenseIdEditor = TextEditingController();

  // instance collection
  final fsCars = FirebaseFirestore.instance.collection('cars');

  // instance storage
  final storageImgRef = FirebaseStorage.instance.ref().child('images/');

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
    setState(() {
      newCarImg = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          color: Colors.white,
          child: ListView(
            children: [
              const Text(
                "Select your new car's image",
                style: TextStyle(fontSize: 22.5, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              newCarImg == null
                  ? GestureDetector(
                      onTap: () {
                        _setCarImgUrl(ImageSource.gallery);
                      },
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 0.5, color: Colors.black),
                        ),
                        child: const Icon(Icons.add, size: 40.0),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        _setCarImgUrl(ImageSource.gallery);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.4,
                        color: Colors.white,
                        child: Center(
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Image.file(
                                File(newCarImg!.path),
                                fit: BoxFit.contain,
                              ),
                              Container(
                                height: 30.0,
                                width: 30.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      newCarImg = null;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.delete_forever_outlined,
                                    size: 20.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
                child: Text('Create', style: TextStyle(fontSize: 20.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
