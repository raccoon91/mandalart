import 'package:flutter/material.dart';
import 'package:mandalart/model/task_model.dart';
import 'package:mandalart/theme/color.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TaskDataSource extends CalendarDataSource {
  TaskDataSource(List<TaskModel>? source) {
    appointments = source ?? [];
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].detailedPlan?.name ?? "";
  }

  @override
  Color getColor(int index) {
    return appointments![index].detailedPlan?.color ?? ColorClass.under;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].allDay;
  }
}
