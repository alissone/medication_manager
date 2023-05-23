import 'package:flutter/material.dart';

String formatTimeOfDay(TimeOfDay timeOfDay) {
  int hours = timeOfDay.hour;
  int minutes = timeOfDay.minute;

  if (hours == 0 && minutes == 0) {
    return '0min';
  }

  String formattedTime = '';
  if (hours > 0) {
    formattedTime += '${hours}h';
  }
  if (minutes > 0) {
    formattedTime += '${minutes}min';
  }

  return formattedTime;
}
