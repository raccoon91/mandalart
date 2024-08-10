import 'package:isar/isar.dart';
import 'package:mandalart/db/isar_db.dart';
import 'package:mandalart/model/task_model.dart';
import 'package:mandalart/schema/detailed_plan_schema.dart';
import 'package:mandalart/schema/task_schema.dart';

class TaskRepository {
  Future<int?> getTaskSize() async {
    try {
      final taskSize = await IsarDB.isar.tasks
          .getSize(includeIndexes: true, includeLinks: true);

      return taskSize;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<TaskModel>?> getWeekTasks(DateTime from, DateTime to) async {
    try {
      var fromDate = from.copyWith(hour: 0, minute: 0, second: 0);
      var toDate = to.copyWith(hour: 11, minute: 59, second: 59);

      final taskSchemaList = await IsarDB.isar.tasks
          .filter()
          .repeatIsNull()
          .fromGreaterThan(fromDate)
          .toLessThan(toDate)
          .findAll();

      List<TaskModel> tasks = [];

      for (var taskSchema in taskSchemaList) {
        var detailedPlanSchema = await IsarDB.isar.detailedPlans
            .filter()
            .idEqualTo(taskSchema.detailedPlanId)
            .findFirst();

        if (detailedPlanSchema == null) continue;

        tasks.add(TaskModel.fromSchema(taskSchema, detailedPlanSchema));
      }

      return tasks;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<TaskModel>?> getEveryDayTask(DateTime from) async {
    try {
      var weekStartDay = from.day;

      final taskSchemaList =
          await IsarDB.isar.tasks.filter().repeatEqualTo("day").findAll();

      List<TaskModel> tasks = [];

      for (var taskSchema in taskSchemaList) {
        var detailedPlanSchema = await IsarDB.isar.detailedPlans
            .filter()
            .idEqualTo(taskSchema.detailedPlanId)
            .findFirst();

        if (detailedPlanSchema == null) continue;

        for (var calib = 0; calib < 7; calib++) {
          taskSchema.from = taskSchema.from.copyWith(
            year: from.year,
            month: from.month,
            day: weekStartDay + calib,
          );
          taskSchema.to = taskSchema.to.copyWith(
            year: from.year,
            month: from.month,
            day: weekStartDay + calib,
          );

          tasks.add(TaskModel.fromSchema(taskSchema, detailedPlanSchema));
        }
      }

      return tasks;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<TaskModel>?> getEveryWeekTask(DateTime from) async {
    try {
      final taskSchemaList =
          await IsarDB.isar.tasks.filter().repeatEqualTo("week").findAll();

      List<TaskModel> tasks = [];

      for (var taskSchema in taskSchemaList) {
        var detailedPlanSchema = await IsarDB.isar.detailedPlans
            .filter()
            .idEqualTo(taskSchema.detailedPlanId)
            .findFirst();

        if (detailedPlanSchema == null) continue;

        taskSchema.from = taskSchema.from.copyWith(
          year: from.year,
          month: from.month,
          day: from.day + taskSchema.from.weekday,
        );
        taskSchema.to = taskSchema.to.copyWith(
          year: from.year,
          month: from.month,
          day: from.day + taskSchema.from.weekday,
        );

        tasks.add(TaskModel.fromSchema(taskSchema, detailedPlanSchema));
      }

      return tasks;
    } catch (error) {
      rethrow;
    }
  }

  // Future<List<TaskModel>?> getEveryMonthTask(int day) async {
  //   try {
  //     final taskSchema =
  //         await IsarDB.isar.tasks.filter().everyMonthEqualTo(day).findAll();

  //     List<TaskModel> tasks = taskSchema.map(TaskModel.fromSchema).toList();

  //     return tasks;
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  Future<TaskModel?> createTask(
    int detailedPlanId,
    DateTime from,
    DateTime to,
    bool? allDay,
    String? repeat,
  ) async {
    try {
      final taskSchema = Task()
        ..detailedPlanId = detailedPlanId
        ..from = from
        ..to = to
        ..allDay = allDay ?? false
        ..repeat = repeat;

      await IsarDB.isar.writeTxn(() async {
        await IsarDB.isar.tasks.put(taskSchema);
      });

      var detailedPlanSchema = await IsarDB.isar.detailedPlans
          .filter()
          .idEqualTo(detailedPlanId)
          .findFirst();

      if (detailedPlanSchema == null) return null;

      final task = TaskModel.fromSchema(taskSchema, detailedPlanSchema);

      return task;
    } catch (error) {
      rethrow;
    }
  }
}
