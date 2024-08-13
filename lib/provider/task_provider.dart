import 'package:flutter/foundation.dart';
import 'package:mandalart/model/task_model.dart';
import 'package:mandalart/repository/task_repository.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/utils/task_data_source.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TaskProvider with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isLoading = false;

  TaskModel? _task;
  List<Appointment> _tasks = [];

  bool get isLoading => _isLoading;

  TaskModel? get task => _task;
  TaskDataSource get tasks => TaskDataSource(_tasks);

  Future<void> getTodayTasks(DateTime date) async {
    try {
      _isLoading = true;

      notifyListeners();

      List<Appointment> appointments = [];

      var weekDayTasks = await TaskRepository().getWeekDayTasks(date);
      var weekendTasks = await TaskRepository().getWeekendTasks(date);
      var weekTasks = await TaskRepository().getWeekTasks(date);
      var everyDayTasks = await TaskRepository().getEveryDayTask(date);
      var everyWeekTasks = await TaskRepository().getEveryWeekTask(date);
      var everyMonthTasks = await TaskRepository().getEveryMonthTask(date);

      List<TaskModel> tasks = [
        ...(weekDayTasks ?? []),
        ...(weekendTasks ?? []),
        ...(weekTasks ?? []),
        ...(everyDayTasks ?? []),
        ...(everyWeekTasks ?? []),
        ...(everyMonthTasks ?? []),
      ];

      for (TaskModel task in tasks) {
        appointments.add(Appointment(
          subject: task.detailedPlan.name ?? '',
          startTime: task.from,
          endTime: task.to,
          isAllDay: task.allDay,
          color: task.detailedPlan.color ?? ColorClass.under,
          resourceIds: [
            {"taskId": task.id}
          ],
        ));
      }

      _tasks = appointments;
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<List<Appointment>>('tasks', _tasks));
  }
}
