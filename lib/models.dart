import 'package:flutter/material.dart';

class Medications {
  List<Medication>? medications;

  Medications({this.medications});

  Medications.fromJson(Map<String, dynamic> json) {
    if (json['medications'] != null) {
      medications = <Medication>[];
      json['medications'].forEach((v) {
        medications!.add(Medication.fromJson(v));
      });
    }
  }

  List<Medication> toList() {
    return medications ?? <Medication>[];
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
    String? startTimeString = json['startTime'];
    String? repeatDelayString = json['repeatDelay'];
    int? colorInt = json['color'];
    dynamic dosageJson = json['dosage'];

    print('name: $name');
    print('startTimeString: $startTimeString');
    print('repeatDelayString: $repeatDelayString');
    print('colorInt: $colorInt');
    print('dosageJson: $dosageJson');

    startTime = _convertStringToTimeOfDay(startTimeString);
    repeatDelay = _convertStringToTimeOfDay(repeatDelayString);
    color = colorInt;
    dosage = dosageJson != null ? Dosage.fromJson(dosageJson) : null;

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
    DateTime dateTime = DateTime.parse(timeString ?? "").toLocal();
    return TimeOfDay.fromDateTime(dateTime);
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

class Example {
  static const ex = """
  Example JSON:
  {"medications":[{"name":"Aspirin","startTime":"2023-05-25T08:00:00Z","repeatDelay":"2023-05-25T12:00:00Z","color":16711680,"dosage":{"value":400,"unit":"mg"}},{"name":"Lipitor","startTime":"2023-05-25T10:30:00Z","repeatDelay":"2023-05-25T18:30:00Z","color":65280,"dosage":{"value":400,"unit":"mg"}},{"name":"Metformin","startTime":"2023-05-25T13:15:00Z","repeatDelay":"2023-05-25T21:15:00Z","color":16776960,"dosage":{"value":400,"unit":"mg"}},{"name":"Synthroid","startTime":"2023-05-25T16:45:00Z","repeatDelay":"2023-05-26T00:45:00Z","color":255,"dosage":{"value":400,"unit":"mg"}},{"name":"Zantac","startTime":"2023-05-25T20:00:00Z","repeatDelay":"2023-05-26T04:00:00Z","color":16711935,"dosage":{"value":400,"unit":"mg"}}]}
  """;
}