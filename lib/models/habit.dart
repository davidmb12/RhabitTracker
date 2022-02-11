import 'dart:ui';

import 'package:flutter/material.dart';

class Habit{
  late String habitName;
  late Color habitColor;
  late DateTime startDate;
  List<int> days=[0,0,0,0,0,0,0];
  late List<DateTime> reminders;

  Habit({required this.habitName,required this.habitColor,required this.startDate,required this.days,required this.reminders});

  factory Habit.fromJson(Map<String,dynamic> parsedJson){
    return Habit(
      habitName:parsedJson['habitName'] ?? "",
      days: parsedJson['days'] ?? "",
      startDate: parsedJson['startDate'] ?? "",
      reminders: parsedJson['reminders'] ?? "",
      habitColor: parsedJson['habitColor'] ?? "",

    );
  }

  Map<String,dynamic> toJson(){
    return{
      "habitName":this.habitName,
      "habitColor":this.habitColor,
      "startDate":this.startDate,
      "days":this.days,
      "reminders":this.reminders,
    };
  }
}