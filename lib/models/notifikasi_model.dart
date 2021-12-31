import 'package:flutter/material.dart';
import 'package:flutter_clock/utils/helper.dart';

class NotifikasiModel {
  final int dayOfTheWeek;
  final DateTime dateTime;
  final TimeOfDay timeOfDay;

  NotifikasiModel({
    required this.dayOfTheWeek,
    required this.timeOfDay,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() => {
        'dayOfTheWeek': dayOfTheWeek,
        'timeOfDay': timeOfDay.toString(),
        'dateTime': dateTime.toIso8601String(),
      };

  factory NotifikasiModel.fromJson(Map<String, dynamic> json) =>
      NotifikasiModel(
        dayOfTheWeek: json['dayOfTheWeek'],
        timeOfDay: Helper().stringToTimeOfDay(json['timeOfDay']),
        dateTime: DateTime.parse(json['dateTime']),
      );
}
