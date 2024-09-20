import 'package:flutter/material.dart';
import 'package:mandalart/schema/plan_schema.dart';
import 'package:mandalart/schema/plan_template_schema.dart';
import 'package:mandalart/schema/schedule_schema.dart';

class ScheduleModel {
  int visionId;
  int id;
  Plan? plan;
  DateTime from;
  DateTime to;
  String? repeat;
  bool isAllDay;
  Color? color;

  ScheduleModel({
    required this.visionId,
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
    Plan? plan = schema.plan.value;
    PlanTemplate? planTemplate = plan?.planTemplate.value;
    Color? color = planTemplate?.color != null ? Color(int.parse(planTemplate!.color!.replaceAll('#', '0xff'))) : null;

    return ScheduleModel(
      visionId: schema.visionId,
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
