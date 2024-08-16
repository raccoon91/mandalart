import 'package:flutter/material.dart';
import 'package:mandalart/schema/plan_schema.dart';
import 'package:mandalart/schema/schedule_schema.dart';

class ScheduleModel {
  int id;
  Plan? plan;
  DateTime from;
  DateTime to;
  String? repeat;
  bool isAllDay;
  Color? color;

  ScheduleModel({
    required this.id,
    required this.plan,
    required this.from,
    required this.to,
    this.repeat,
    required this.isAllDay,
    this.color,
  });

  factory ScheduleModel.fromSchema(
    Schedule schema,
    DateTime from,
    DateTime to,
  ) {
    Color? color = schema.plan.value?.color != null
        ? Color(schema.plan.value!.color!)
        : null;

    return ScheduleModel(
      id: schema.id,
      plan: schema.plan.value,
      from: from,
      to: to,
      repeat: schema.repeat,
      isAllDay: schema.isAllDay,
      color: color,
    );
  }
}
