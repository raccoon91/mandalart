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

  Future<void> getTasks(DateTime? date) async {
    try {
      if (date != null) {
        _target = date;
        _start = date.subtract(Duration(
          days: date.weekday == 7 ? 0 : date.weekday,
        ));
      }

      if (_start == null) return;

      List<TaskModel> tasks = [];

      var weekSchedules = await ScheduleRepository.getThisWeek(_start!);
      var weekDaySchedules = await ScheduleRepository.getWeekDay(_start!);
      var weekendSchedules = await ScheduleRepository.getWeekend(_start!);
      var everyDaySchedules = await ScheduleRepository.getEveryDay(_start!);
      var everyWeekSchedules = await ScheduleRepository.getEveryWeek(_start!);
      var everyMonthSchedules = await ScheduleRepository.getEveryMonth(_start!);

      List<ScheduleModel> schedules = [
        ...(weekSchedules ?? []),
        ...(weekDaySchedules ?? []),
        ...(weekendSchedules ?? []),
        ...(everyDaySchedules ?? []),
        ...(everyWeekSchedules ?? []),
        ...(everyMonthSchedules ?? []),
      ];

      for (ScheduleModel schedule in schedules) {
        if (schedule.from.day != _target.day) continue;

        var complete = await CompleteRepository.get(schedule.id, schedule.from);

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

  Future<void> updateTask(int? scheduleId, DateTime date) async {
    try {
      List<TaskModel> tasks = [];

      for (var schedule in _schedules) {
        if (schedule.from.day != date.day) continue;

        var complete = await CompleteRepository.get(schedule.id, schedule.from);

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

  Future<void> toggleTodo(
    int? completeId,
    int? scheduleId,
    DateTime? date,
  ) async {
    try {
      if (completeId == null) {
        await CompleteRepository.create(scheduleId, date);
      } else {
        await CompleteRepository.delete(completeId);
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
