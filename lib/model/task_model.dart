import 'package:flutter/material.dart';
import 'package:mandalart/model/schedule_model.dart';
import 'package:mandalart/schema/complete_schema.dart';
import 'package:mandalart/schema/plan_schema.dart';
import 'package:mandalart/schema/plan_template_schema.dart';
import 'package:mandalart/theme/color.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TaskModel extends Appointment {
  int? visionId;
  int? scheduleId;
  int? completeId;
  DateTime? completed;
  Color borderColor;

  TaskModel({
    this.visionId,
    this.scheduleId,
    this.completeId,
    required super.subject,
    required super.startTime,
    required super.endTime,
    required super.isAllDay,
    required super.color,
    this.completed,
    required this.borderColor,
  });

  factory TaskModel.fromSchema(ScheduleModel schedule, Complete? completeSchema) {
    Plan? plan = schedule.plan;
    PlanTemplate? planTemplate = plan?.planTemplate.value;

    return TaskModel(
      visionId: schedule.visionId,
      scheduleId: schedule.id,
      completeId: completeSchema?.id,
      completed: completeSchema?.completed,
      subject: planTemplate?.name ?? '',
      startTime: schedule.from,
      endTime: schedule.to,
      isAllDay: schedule.isAllDay,
      color: completeSchema?.completed == null ? ColorClass.white : schedule.color ?? ColorClass.under,
      borderColor: schedule.color ?? ColorClass.under,
    );
  }
}
