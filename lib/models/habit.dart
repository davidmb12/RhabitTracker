import 'dart:ui';

import 'package:flutter/material.dart';

class Habit{
  late String habitName;
  late Color habitColor;
  late DateTime startDate;
  late Duration habitDuration;
  List<int> days=[0,0,0,0,0,0,0];
  late List<HourFormat> reminders;

  Habit({required this.habitName,required this.habitColor,required this.startDate,required this.habitDuration,required this.days,required this.reminders});

  factory Habit.fromJson(Map<String,dynamic> parsedJson){
    return Habit(
      habitName:parsedJson['habitName'] ?? "",
      days: parsedJson['days'] ?? "",
      startDate: parsedJson['startDate'] ?? "",
      reminders: parsedJson['reminders'] ?? "",
      habitDuration: parsedJson['habitDuration'] ?? "",
      habitColor: parsedJson['habitColor'] ?? "",

    );
  }

  Map<String,dynamic> toJson(){
    return{
      "habitName":this.habitName,
      "habitColor":this.habitColor,
      "startDate":this.startDate,
      "habitDuration":this.habitDuration,
      "days":this.days,
      "reminders":this.reminders,
    };
  }
}