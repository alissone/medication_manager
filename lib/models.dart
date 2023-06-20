import 'package:flutter/material.dart';
import 'package:medication_manager/Utils/extensions.dart';

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
  int? id;
  String? name;
  TimeOfDay? startTime;
  TimeOfDay? repeatDelay;
  String? color;
  Dosage? dosage;

  Medication({
    this.id,
    this.name,
    this.startTime,
    this.repeatDelay,
    this.color,
    this.dosage,
  });

  @override
  String toString() {
    return 'Medication(name: $name, startTime: $startTime, repeatDelay: $repeatDelay, color: $color, dosage: $dosage)';
  }

  Medication.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    String? startTimeString = json['startTime'];
    String? repeatDelayString = json['repeatDelay'];
    String? colorString = json['color'];
    dynamic dosageJson = json['dosage'];

    print('id: $id');
    print('name: $name');
    print('startTimeString: $startTimeString');
    print('repeatDelayString: $repeatDelayString');
    print('colorInt: $colorString');
    print('dosageJson: $dosageJson');

    startTime = _convertStringToTimeOfDay(startTimeString);
    repeatDelay = _convertStringToTimeOfDay(repeatDelayString);
    color = colorString;
    dosage = dosageJson != null ? Dosage.fromJson(dosageJson) : null;
  }

  Map<String, dynamic> toJson() {
    Color myColor = HexColor.fromHex(color ?? "");
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['startTime'] = _convertTimeOfDayToString(startTime);
    data['repeatDelay'] = _convertTimeOfDayToString(repeatDelay);
    data['color'] = myColor.toHex();
    if (dosage != null) {
      data['dosage'] = dosage!.toJson();
    }
    return data;
  }

  Map<String, dynamic> toMap() {
    Color myColor = HexColor.fromHex(color ?? "");
    return {
      'id': id,
      'name': name,
      'startTime': _convertTimeOfDayToString(startTime),
      'repeatDelay': _convertTimeOfDayToString(repeatDelay),
      'color': myColor.toHex(),
      'dosage': dosage?.toMap(),
    };
  }

  bool hasDate(String dateTimeString) {
    return dateTimeString.length > 5;
  }

  Medication.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];

    if (hasDate(map['startTime'])) {
      startTime = TimeOfDay.fromDateTime(DateTime.parse(map['startTime']));
    } else {
      startTime = TimeOfDay(
          hour: int.parse(map['startTime'].split(':')[0]),
          minute: int.parse(map['startTime'].split(':')[1]));
    }

    if (hasDate(map['repeatDelay'])) {
      repeatDelay = TimeOfDay.fromDateTime(DateTime.parse(map['repeatDelay']));
    } else {
      repeatDelay = TimeOfDay(
          hour: int.parse(map['repeatDelay'].split(':')[0]),
          minute: int.parse(map['repeatDelay'].split(':')[1]));
    }

    color = map['color'];
    dosage = Dosage(unit: map['dosage']['unit'], value: map['dosage']['value']);
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

  void updateName(String newName) {
    name = newName;
  }

  void updateStartDate(TimeOfDay newStartDate) {
    print("new end date: $newStartDate");
  }

  void updateEndDate(TimeOfDay newEndDate) {
    print("new end date: $newEndDate");
  }

  void updateStartTime(TimeOfDay newStartTime) {
    startTime = newStartTime;
  }

  void updateInterval(TimeOfDay newInterval) {
    repeatDelay = newInterval;
  }

  void updateUnit(String newUnit) {
    dosage?.unit = newUnit;
  }

  void updateWeight(String newValue) {
    dosage?.value = int.tryParse(newValue) ?? 0;
  }

  void updateUrgency(String urgency) {
    print('new urgency $urgency');
  }
}

class Dosage {
  int? value;
  String? unit;

  Dosage({this.value, this.unit});

  @override
  String toString() {
    return 'Dosage(unit: $unit, value: $value)';
  }

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

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'unit': unit,
    };
  }
}

class Examples {
  static const ex = """
  Example JSON:
  {"medications":[{"name":"Aspirin","startTime":"2023-05-25T08:00:00Z","repeatDelay":"2023-05-25T12:00:00Z","color":16711680,"dosage":{"value":400,"unit":"mg"}},{"name":"Lipitor","startTime":"2023-05-25T10:30:00Z","repeatDelay":"2023-05-25T18:30:00Z","color":65280,"dosage":{"value":400,"unit":"mg"}},{"name":"Metformin","startTime":"2023-05-25T13:15:00Z","repeatDelay":"2023-05-25T21:15:00Z","color":16776960,"dosage":{"value":400,"unit":"mg"}},{"name":"Synthroid","startTime":"2023-05-25T16:45:00Z","repeatDelay":"2023-05-26T00:45:00Z","color":255,"dosage":{"value":400,"unit":"mg"}},{"name":"Zantac","startTime":"2023-05-25T20:00:00Z","repeatDelay":"2023-05-26T04:00:00Z","color":16711935,"dosage":{"value":400,"unit":"mg"}}]}
  """;
}
