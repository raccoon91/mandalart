import 'package:flutter/material.dart';
import 'package:mandalart/model/schedule_model.dart';
import 'package:mandalart/schema/complete_schema.dart';
import 'package:mandalart/theme/color.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TaskModel extends Appointment {
  int? completeId;
  int? scheduleId;
  DateTime? completed;
  Color borderColor;

  TaskModel({
    required super.subject,
    required super.startTime,
    required super.endTime,
    required super.isAllDay,
    required super.color,
    this.completeId,
    this.scheduleId,
    this.completed,
    required this.borderColor,
  });

  factory TaskModel.fromSchema(
    ScheduleModel schedule,
    Complete? completeSchema,
  ) {
    return TaskModel(
      completeId: completeSchema?.id,
      scheduleId: schedule.id,
      completed: completeSchema?.completed,
      subject: schedule.plan?.name ?? '',
      startTime: schedule.from,
      endTime: schedule.to,
      isAllDay: schedule.isAllDay,
      color: completeSchema?.completed == null
          ? ColorClass.white
          : schedule.color ?? ColorClass.under,
      borderColor: schedule.color ?? ColorClass.under,
    );
  }
}
