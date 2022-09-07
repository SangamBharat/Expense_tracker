import 'package:flutter/foundation.dart';

class Trans {
  String id;
  String title;
  double price;
  DateTime dt;

  Trans(
      {required this.dt,
      required this.id,
      required this.price,
      required this.title});
}
