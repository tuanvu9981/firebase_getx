import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_getx/models/car.model.dart';
import 'package:firebase_getx/screens/update_car_screen.dart';
import 'package:flutter/material.dart';

class CarCard extends StatelessWidget {
  Car? car;
  void Function(String? id) removeCar;
  CarCard({this.car, Key? key, required this.removeCar}) : super(key: key);

  final txtStyle = const TextStyle(fontSize: 16.5, color: Colors.black);
  final fsCars = FirebaseFirestore.instance.collection('cars');

  Future<void> _deleteCarById(String? licenseId) async {
    final query = await fsCars.where('licenseId', isEqualTo: licenseId).get();
    DocumentReference ref = query.docs[0].reference;
    await ref.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0.0, 2.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image(
                      image: NetworkImage(car!.imageUrl!),
                      fit: BoxFit.fill,
                      height: 120.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.precision_manufacturing_outlined,
                          size: 27.5,
                          color: Colors.orange[300],
                        ),
                        const SizedBox(width: 10.0),
                        Text(car?.maker ?? "", style: txtStyle),
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    Row(
                      children: [
                        Icon(
                          Icons.app_registration_rounded,
                          size: 27.5,
                          color: Colors.orange[300],
                        ),
                        const SizedBox(width: 10.0),
                        Text(car?.licenseId ?? "", style: txtStyle),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: const Text('Are you sure to delete?'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Delete'),
                              onPressed: () {
                                removeCar(car!.licenseId);
                                _deleteCarById(car!.licenseId);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Icon(Icons.delete, size: 27.5, color: Colors.red),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => UpdateCarScreen(car: car!)),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.change_circle_outlined,
                    size: 27.5,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
