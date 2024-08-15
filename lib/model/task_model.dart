import 'package:mandalart/extension/number_format_extension.dart';
import 'package:mandalart/model/schedule_model.dart';
import 'package:mandalart/schema/schedule_schema.dart';
import 'package:mandalart/schema/task_schema.dart';
import 'package:mandalart/theme/color.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TaskModel extends Appointment {
  int taskId;
  DateTime completed;

  TaskModel({
    required super.subject,
    required super.startTime,
    required super.endTime,
    required super.isAllDay,
    required super.color,
    required this.taskId,
    required this.completed,
  });

  factory TaskModel.fromSchema(Task taskSchema, Schedule scheduleSchema) {
    var from = DateTime(
      scheduleSchema.year,
      scheduleSchema.month,
      scheduleSchema.day,
      scheduleSchema.start.toHour(),
      scheduleSchema.start.toMinute(),
    );

    var to = DateTime(
      scheduleSchema.year,
      scheduleSchema.month,
      scheduleSchema.day,
      scheduleSchema.end.toHour(),
      scheduleSchema.end.toMinute(),
    );

    ScheduleModel schdule = ScheduleModel.fromSchema(scheduleSchema, from, to);

    return TaskModel(
      taskId: taskSchema.id,
      completed: taskSchema.completed,
      subject: schdule.plan?.name ?? '',
      startTime: schdule.from,
      endTime: schdule.to,
      isAllDay: schdule.isAllDay,
      color: schdule.color ?? ColorClass.under,
    );
  }
}
