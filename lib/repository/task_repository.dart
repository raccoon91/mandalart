import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:mandalart/db/isar_db.dart';
import 'package:mandalart/model/task_model.dart';
import 'package:mandalart/schema/task_schema.dart';

class TaskRepository {
  Future<List<TaskModel>?> getTodayTask() async {
    try {
      var today = DateTime.now();
      var fromDate = today.copyWith(hour: 0, minute: 0, second: 0);
      var toDate = today.copyWith(hour: 11, minute: 59, second: 59);

      final tasksSchema = await IsarDB.isar.tasks
          .filter()
          .fromGreaterThan(fromDate)
          .toLessThan(toDate)
          .findAll();

      List<TaskModel> tasks = tasksSchema.map(TaskModel.fromSchema).toList();

      return tasks;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<TaskModel>?> getEveryDayTask() async {
    try {
      final tasksSchema =
          await IsarDB.isar.tasks.filter().everyDayEqualTo(true).findAll();

      List<TaskModel> tasks = tasksSchema.map(TaskModel.fromSchema).toList();

      return tasks;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<TaskModel>?> getEveryWeekTask(int weekday) async {
    try {
      final tasksSchema =
          await IsarDB.isar.tasks.filter().everyWeekEqualTo(weekday).findAll();

      List<TaskModel> tasks = tasksSchema.map(TaskModel.fromSchema).toList();

      return tasks;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<TaskModel>?> getEveryMonthTask(int day) async {
    try {
      final tasksSchema =
          await IsarDB.isar.tasks.filter().everyMonthEqualTo(day).findAll();

      List<TaskModel> tasks = tasksSchema.map(TaskModel.fromSchema).toList();

      return tasks;
    } catch (error) {
      rethrow;
    }
  }

  Future<TaskModel> createTask(
    String name,
    DateTime from,
    DateTime to,
    Color color,
    bool allDay,
    bool everyDay,
    int? everyWeek,
    int? everyMonth,
  ) async {
    try {
      int colorValue = color.value;

      final taskSchema = Task()
        ..name = name
        ..from = from
        ..to = to
        ..color = colorValue
        ..allDay = allDay
        ..everyDay = everyDay
        ..everyWeek = everyWeek
        ..everyMonth = everyMonth;

      await IsarDB.isar.tasks.put(taskSchema);

      final project = TaskModel.fromSchema(taskSchema);

      return project;
    } catch (error) {
      rethrow;
    }
  }
}
