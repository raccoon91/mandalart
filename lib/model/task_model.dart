import 'package:flutter/material.dart';
import 'package:mandalart/model/detailed_plan_model.dart';
import 'package:mandalart/schema/detailed_plan_schema.dart';
import 'package:mandalart/schema/task_schema.dart';

class TaskModel {
  int detailedPlanId;
  DetailedPlanModel detailedPlan;
  DateTime from;
  DateTime to;
  DateTime? terminate;
  Color? color;
  bool allDay;
  String? repeat;

  TaskModel({
    required this.detailedPlanId,
    required this.detailedPlan,
    required this.from,
    required this.to,
    this.terminate,
    this.color,
    required this.allDay,
    this.repeat,
  });

  factory TaskModel.fromSchema(
    Task taskSchema,
    DetailedPlan detailedPlanSchema,
  ) {
    Color? color = taskSchema.color != null ? Color(taskSchema.color!) : null;
    var detailedPlan = DetailedPlanModel.fromSchema(detailedPlanSchema);

    return TaskModel(
      detailedPlanId: taskSchema.detailedPlanId,
      detailedPlan: detailedPlan,
      from: taskSchema.from,
      to: taskSchema.to,
      terminate: taskSchema.terminate,
      color: color,
      allDay: taskSchema.allDay,
      repeat: taskSchema.repeat,
    );
  }
}
