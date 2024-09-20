import 'package:flutter/foundation.dart';
import 'package:mandalart/model/schedule_model.dart';
import 'package:mandalart/model/task_model.dart';
import 'package:mandalart/repository/complete_repository.dart';
import 'package:mandalart/repository/schedule_repository.dart';
import 'package:mandalart/utils/calendar_data.dart';

class TaskProvider with ChangeNotifier, DiagnosticableTreeMixin {
  DateTime _target = DateTime.now();
  DateTime? _start;

  ScheduleModel? _schedule;
  List<ScheduleModel> _schedules = [];
  List<TaskModel> _tasks = [];

  ScheduleModel? get schedule => _schedule;
  List<ScheduleModel> get schedules => _schedules;
  CalendarData get tasks => CalendarData(_tasks);

  Future<void> getTasks({DateTime? date}) async {
    try {
      if (date != null) {
        _target = date;
        _start = date.subtract(Duration(days: date.weekday == 7 ? 0 : date.weekday));
      }

      if (_start == null) return;

      List<TaskModel> tasks = [];

      var weekSchedules = await ScheduleRepository().getThisWeek(start: _start!);
      var weekDaySchedules = await ScheduleRepository().getWeekDay(start: _start!);
      var weekendSchedules = await ScheduleRepository().getWeekend(start: _start!);
      var everyDaySchedules = await ScheduleRepository().getEveryDay(start: _start!);
      var everyWeekSchedules = await ScheduleRepository().getEveryWeek(start: _start!);
      var everyMonthSchedules = await ScheduleRepository().getEveryMonth(start: _start!);

      List<ScheduleModel> schedules = [
        ...(weekSchedules),
        ...(weekDaySchedules ?? []),
        ...(weekendSchedules ?? []),
        ...(everyDaySchedules ?? []),
        ...(everyWeekSchedules ?? []),
        ...(everyMonthSchedules ?? []),
      ];

      for (ScheduleModel schedule in schedules) {
        if (schedule.from.day != _target.day) continue;

        var complete = await CompleteRepository().getComplete(scheduleId: schedule.id, date: schedule.to);

        var task = TaskModel.fromSchema(schedule, complete);

        tasks.add(task);
      }

      _schedules = schedules;
      _tasks = tasks;
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateTask({int? scheduleId, required DateTime date}) async {
    try {
      List<TaskModel> tasks = [];

      for (var schedule in _schedules) {
        if (schedule.from.day != date.day) continue;

        var complete = await CompleteRepository().getComplete(scheduleId: schedule.id, date: schedule.from);

        var task = TaskModel.fromSchema(schedule, complete);

        tasks.add(task);
      }

      _tasks = tasks;
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> toggleTask({required TaskModel task}) async {
    try {
      if (task.completeId == null) {
        await CompleteRepository().createComplete(
          visionId: task.visionId,
          scheduleId: task.scheduleId,
          date: task.endTime,
        );
      } else {
        await CompleteRepository().deleteComplete(completeId: task.completeId);
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ScheduleModel>('schedule', _schedule));
    properties.add(DiagnosticsProperty<List<ScheduleModel>>('schedules', _schedules));
    properties.add(DiagnosticsProperty<List<TaskModel>>('tasks', _tasks));
  }
}
