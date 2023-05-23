import 'package:flutter/material.dart';

enum MedicationColor { vermelho, verde, azul, laranja }

class Medication {
  String name;
  TimeOfDay startTime;
  TimeOfDay repeatDelay;
  MedicationColor color;

  Medication({
    required this.name,
    required this.startTime,
    required this.repeatDelay,
    required this.color,
  });
}

