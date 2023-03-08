import 'package:firebase_getx/models/car.model.dart';
import 'package:flutter/material.dart';

class CarCard extends StatelessWidget {
  Car? car;
  CarCard({this.car, Key? key}) : super(key: key);

  final txtStyle = const TextStyle(fontSize: 16.5, color: Colors.black);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.symmetric(vertical: 5.0),
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
                child: Image(
                  image: NetworkImage(car!.imageUrl!),
                  fit: BoxFit.cover,
                  height: 120.0,
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
                  onTap: () {},
                  child: Icon(Icons.delete, size: 27.5, color: Colors.red),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {},
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
