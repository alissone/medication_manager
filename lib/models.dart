import 'package:flutter/material.dart';

class Medication {
String name;
TimeOfDay startTime;
TimeOfDay repeatDelay;
Color color;
Dosage dosage;

Medication({
  required this.name,
  required this.startTime,
  required this.repeatDelay,
  required this.color,
  required this.dosage,
});
}

class Dosage {
  double quantity;
  String unit;

  Dosage(this.quantity, this.unit);
}

