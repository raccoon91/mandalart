import 'package:flutter/foundation.dart';
import 'package:mandalart/model/schedule_model.dart';
import 'package:mandalart/model/todo_model.dart';
import 'package:mandalart/repository/schedule_repository.dart';
import 'package:mandalart/repository/task_repository.dart';
import 'package:mandalart/repository/vision_repository.dart';

class TodoProvider with ChangeNotifier, DiagnosticableTreeMixin {
  ScheduleModel? _schedule;
  List<ScheduleModel> _schedules = [];
  List<TodoModel> _todos = [];

  ScheduleModel? get schedule => _schedule;
  List<ScheduleModel> get schedules => _schedules;
  List<TodoModel> get todos => _todos;

  Future<void> getTasks(DateTime date) async {
    try {
      DateTime start = date.subtract(Duration(
        days: date.weekday == 7 ? 0 : date.weekday,
      ));

      List<TodoModel> todos = [];

      var weekSchedules = await ScheduleRepository.gets(start);
      var weekDaySchedules = await ScheduleRepository.getWeekDay(start);
      var weekendSchedules = await ScheduleRepository.getWeekend(start);
      var everyDaySchedules = await ScheduleRepository.getEveryDay(start);
      var everyWeekSchedules = await ScheduleRepository.getEveryWeek(start);
      var everyMonthSchedules = await ScheduleRepository.getEveryMonth(start);

      List<ScheduleModel> schedules = [
        ...(weekSchedules ?? []),
        ...(weekDaySchedules ?? []),
        ...(weekendSchedules ?? []),
        ...(everyDaySchedules ?? []),
        ...(everyWeekSchedules ?? []),
        ...(everyMonthSchedules ?? []),
      ];

      for (ScheduleModel schedule in schedules) {
        if (schedule.from.day != date.day) continue;

        var task = await TaskRepository.get(schedule.id, schedule.from);

        var todo = TodoModel.fromSchema(schedule, task);

        todos.add(todo);
      }

      _schedules = schedules;
      _todos = todos;
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateTask(int? scheduleId, DateTime date) async {
    try {
      List<TodoModel> todos = [];

      for (var schedule in _schedules) {
        if (schedule.from.day != date.day) continue;

        var task = await TaskRepository.get(schedule.id, schedule.from);

        print(schedule.plan?.name);
        print(task?.id);

        var todo = TodoModel.fromSchema(schedule, task);

        todos.add(todo);
      }

      _todos = todos;
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> toggleTodo(int? taskId, int? scheduleId, DateTime? date) async {
    try {
      var vision = await VisionRepository.get();

      if (vision == null) return;

      if (taskId == null) {
        await TaskRepository.create(vision.id, scheduleId, date);
      } else {
        await TaskRepository.delete(taskId);
      }
    } catch (error) {
      rethrow;
    }
  }

  void clearTodo() {
    _schedules = [];
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<List<ScheduleModel>>('schedules', _schedules),
    );
  }
}
