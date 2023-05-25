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

class Todo {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  Todo(
      {required this.userId,
      required this.id,
      required this.title,
      required this.completed});

  factory Todo.fromJson(Map<String, dynamic> json) {
    final int userId = json['userId'] ?? 0;
    final int id = json['id'] ?? 0;
    final String title = json['title'] ?? "empty";
    final bool completed = json['completed'] ?? false;

    return Todo(
      userId: userId,
      id: id,
      title: title,
      completed: completed,
    );
  }
}
