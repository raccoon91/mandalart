import 'package:mandalart/model/task_model.dart';
import 'package:mandalart/theme/color.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TodoModel extends Appointment {
  int taskId;
  int? doneId;

  TodoModel({
    required this.taskId,
    required this.doneId,
    super.subject,
    required super.startTime,
    required super.endTime,
    super.isAllDay,
    super.color,
  });

  factory TodoModel.fromTask(TaskModel task, int? doneId) {
    return TodoModel(
      subject: task.detailedPlan.name ?? '',
      startTime: task.from,
      endTime: task.to,
      isAllDay: task.allDay,
      color: task.detailedPlan.color ?? ColorClass.under,
      taskId: task.id,
      doneId: doneId,
    );
  }
}
