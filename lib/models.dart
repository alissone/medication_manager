import 'package:flutter/material.dart';

class Medications {
  List<Medications>? medications;

  Medications({this.medications});

  Medications.fromJson(Map<String, dynamic> json) {
    if (json['medications'] != null) {
      medications = <Medications>[];
      json['medications'].forEach((v) {
        medications!.add(Medications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (medications != null) {
      data['medications'] = medications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Medication {
  String? name;
  TimeOfDay? startTime;
  TimeOfDay? repeatDelay;
  int? color;
  Dosage? dosage;

  Medication({
    this.name,
    this.startTime,
    this.repeatDelay,
    this.color,
    this.dosage,
  });

  Medication.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    startTime = _convertStringToTimeOfDay(json['startTime']);
    repeatDelay = _convertStringToTimeOfDay(json['repeatDelay']);
    color = json['color'];
    dosage = json['dosage'] != null ? Dosage.fromJson(json['dosage']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['startTime'] = _convertTimeOfDayToString(startTime);
    data['repeatDelay'] = _convertTimeOfDayToString(repeatDelay);
    data['color'] = color;
    if (dosage != null) {
      data['dosage'] = dosage!.toJson();
    }
    return data;
  }

  TimeOfDay _convertStringToTimeOfDay(String? timeString) {
    if (timeString == null) {
      return TimeOfDay.now();
    }
    final parts = timeString.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  String _convertTimeOfDayToString(TimeOfDay? timeOfDay) {
    if (timeOfDay == null) {
      return '';
    }
    return '${timeOfDay.hour}:${timeOfDay.minute}';
  }
}


class Dosage {
  int? value;
  String? unit;

  Dosage({this.value, this.unit});

  Dosage.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['unit'] = unit;
    return data;
  }
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
