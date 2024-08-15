import 'package:flutter/foundation.dart';
import 'package:mandalart/model/task_model.dart';
import 'package:mandalart/model/todo_model.dart';
import 'package:mandalart/repository/task_repository.dart';
import 'package:mandalart/repository/todo_repository.dart';
import 'package:mandalart/theme/color.dart';

class TaskProvider with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isLoading = false;

  TaskModel? _task;
  List<TodoModel> _tasks = [];

  bool get isLoading => _isLoading;

  TaskModel? get task => _task;
  List<TodoModel> get tasks => (_tasks);

  Future<void> getTodayTasks(DateTime date) async {
    try {
      _isLoading = true;

      DateTime start = date.subtract(Duration(
        days: date.weekday == 7 ? 0 : date.weekday,
      ));

      notifyListeners();

      List<TodoModel> appointments = [];

      var weekDayTasks = await TaskRepository().getWeekDayTasks(start);
      var weekendTasks = await TaskRepository().getWeekendTasks(start);
      var weekTasks = await TaskRepository().getWeekTasks(start);
      var everyDayTasks = await TaskRepository().getEveryDayTask(start);
      var everyWeekTasks = await TaskRepository().getEveryWeekTask(start);
      var everyMonthTasks = await TaskRepository().getEveryMonthTask(start);

      List<TaskModel> tasks = [
        ...(weekDayTasks ?? []),
        ...(weekendTasks ?? []),
        ...(weekTasks ?? []),
        ...(everyDayTasks ?? []),
        ...(everyWeekTasks ?? []),
        ...(everyMonthTasks ?? []),
      ];

      for (TaskModel task in tasks) {
        if (task.from.day != date.day) continue;

        var doneSchema = await TodoRepository().getTodo(task.id, task.from);

        appointments.add(TodoModel(
          taskId: task.id,
          doneId: doneSchema?.id,
          subject: task.detailedPlan.name ?? '',
          startTime: task.from,
          endTime: task.to,
          isAllDay: task.allDay,
          color: task.detailedPlan.color ?? ColorClass.under,
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

  Future<void> updateTodayTasks(int taskId, DateTime date) async {
    try {
      _isLoading = true;

      notifyListeners();

      List<TodoModel> appointments = [];

      for (var task in _tasks) {
        if (task.taskId == taskId) {
          var doneSchema = await TodoRepository().getTodo(taskId, date);

          task.doneId = doneSchema?.id;
        }

        appointments.add(task);
      }

      _tasks = appointments;
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  Future<void> toggleTodo(int? doneId, int taskId, DateTime? date) async {
    try {
      if (doneId == null) {
        await TodoRepository().createTodo(taskId, date);
      } else {
        await TodoRepository().deleteTodo(doneId);
      }
    } catch (error) {
      rethrow;
    }
  }

  void clearTodo() {
    _tasks = [];
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<List<TodoModel>>('tasks', _tasks));
  }
}
