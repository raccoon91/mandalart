import 'package:flutter/material.dart';
import 'package:mandalart/schema/task_schema.dart';

class TaskModel {
  String name;
  DateTime from;
  DateTime to;
  Color? color;
  bool allDay;
  bool everyDay;
  int? everyWeek;
  int? everyMonth;

  TaskModel({
    required this.name,
    required this.from,
    required this.to,
    this.color,
    required this.allDay,
    required this.everyDay,
    required this.everyWeek,
    required this.everyMonth,
  });

  factory TaskModel.fromSchema(Task schema) {
    Color? color = schema.color != null ? Color(schema.color!) : null;

    return TaskModel(
      name: schema.name,
      from: schema.from,
      to: schema.to,
      color: color,
      allDay: schema.allDay,
      everyDay: schema.everyDay,
      everyWeek: schema.everyWeek,
      everyMonth: schema.everyMonth,
    );
  }
}
