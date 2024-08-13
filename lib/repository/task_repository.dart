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

  Future<TaskModel?> getTask(int taskId) async {
    try {
      final taskSchema =
          await IsarDB.isar.tasks.filter().idEqualTo(taskId).findFirst();

      if (taskSchema == null) return null;

      var detailedPlanSchema = await IsarDB.isar.detailedPlans
          .filter()
          .idEqualTo(taskSchema.detailedPlanId)
          .findFirst();

      if (detailedPlanSchema == null) return null;

      TaskModel task = TaskModel.fromSchema(taskSchema, detailedPlanSchema);

      return task;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<TaskModel>?> getWeekDayTasks(DateTime date) async {
    try {
      var weekStartDay = date.day;

      final taskSchemaList = await IsarDB.isar.tasks
          .filter()
          .repeatEqualTo("weekdays")
          .weekdayEqualTo(true)
          .findAll();

      List<TaskModel> tasks = [];

      for (var taskSchema in taskSchemaList) {
        var detailedPlanSchema = await IsarDB.isar.detailedPlans
            .filter()
            .idEqualTo(taskSchema.detailedPlanId)
            .findFirst();

        if (detailedPlanSchema == null) continue;

        for (var calib = 1; calib < 6; calib++) {
          var taskFrom = taskSchema.from.copyWith(
            year: date.year,
            month: date.month,
            day: weekStartDay + calib,
          );
          var taskTo = taskSchema.to.copyWith(
            year: date.year,
            month: date.month,
            day: weekStartDay + calib,
          );

          if (taskSchema.terminate != null &&
              taskTo.isAfter(taskSchema.terminate!)) {
            continue;
          }

          taskSchema.from = taskFrom;
          taskSchema.to = taskTo;

          tasks.add(TaskModel.fromSchema(taskSchema, detailedPlanSchema));
        }
      }

      return tasks;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<TaskModel>?> getWeekendTasks(DateTime date) async {
    try {
      var weekStartDay = date.day;

      final taskSchemaList = await IsarDB.isar.tasks
          .filter()
          .repeatEqualTo("weekend")
          .weekendEqualTo(true)
          .findAll();

      List<TaskModel> tasks = [];

      for (var taskSchema in taskSchemaList) {
        var detailedPlanSchema = await IsarDB.isar.detailedPlans
            .filter()
            .idEqualTo(taskSchema.detailedPlanId)
            .findFirst();

        if (detailedPlanSchema == null) continue;

        for (var calib in [0, 6]) {
          var taskFrom = taskSchema.from.copyWith(
            year: date.year,
            month: date.month,
            day: weekStartDay + calib,
          );
          var taskTo = taskSchema.to.copyWith(
            year: date.year,
            month: date.month,
            day: weekStartDay + calib,
          );

          if (taskSchema.terminate != null &&
              taskTo.isAfter(taskSchema.terminate!)) {
            continue;
          }

          taskSchema.from = taskFrom;
          taskSchema.to = taskTo;

          tasks.add(TaskModel.fromSchema(taskSchema, detailedPlanSchema));
        }
      }

      return tasks;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<TaskModel>?> getWeekTasks(DateTime date) async {
    try {
      var fromDate = date.copyWith(hour: 0, minute: 0, second: 0);
      var toDate = date.copyWith(hour: 11, minute: 59, second: 59);

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

  Future<List<TaskModel>?> getEveryDayTask(DateTime date) async {
    try {
      var weekStartDay = date.day;

      final taskSchemaList = await IsarDB.isar.tasks
          .filter()
          .repeatEqualTo("day")
          .everyDayEqualTo(true)
          .findAll();

      List<TaskModel> tasks = [];

      for (var taskSchema in taskSchemaList) {
        var detailedPlanSchema = await IsarDB.isar.detailedPlans
            .filter()
            .idEqualTo(taskSchema.detailedPlanId)
            .findFirst();

        if (detailedPlanSchema == null) continue;

        for (var calib = 0; calib < 7; calib++) {
          var taskFrom = taskSchema.from.copyWith(
            year: date.year,
            month: date.month,
            day: weekStartDay + calib,
          );
          var taskTo = taskSchema.to.copyWith(
            year: date.year,
            month: date.month,
            day: weekStartDay + calib,
          );

          if (taskSchema.terminate != null &&
              taskTo.isAfter(taskSchema.terminate!)) {
            continue;
          }

          taskSchema.from = taskFrom;
          taskSchema.to = taskTo;

          tasks.add(TaskModel.fromSchema(taskSchema, detailedPlanSchema));
        }
      }

      return tasks;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<TaskModel>?> getEveryWeekTask(DateTime date) async {
    try {
      final taskSchemaList = await IsarDB.isar.tasks
          .filter()
          .repeatEqualTo("week")
          .everyWeekIsNotNull()
          .findAll();

      List<TaskModel> tasks = [];

      for (var taskSchema in taskSchemaList) {
        var detailedPlanSchema = await IsarDB.isar.detailedPlans
            .filter()
            .idEqualTo(taskSchema.detailedPlanId)
            .findFirst();

        if (detailedPlanSchema == null) continue;

        var taskFrom = taskSchema.from.copyWith(
          year: date.year,
          month: date.month,
          day: date.day + taskSchema.from.weekday,
        );
        var taskTo = taskSchema.to.copyWith(
          year: date.year,
          month: date.month,
          day: date.day + taskSchema.from.weekday,
        );

        if (taskSchema.terminate != null &&
            taskTo.isAfter(taskSchema.terminate!)) {
          continue;
        }

        taskSchema.from = taskFrom;
        taskSchema.to = taskTo;

        tasks.add(TaskModel.fromSchema(taskSchema, detailedPlanSchema));
      }

      return tasks;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<TaskModel>?> getEveryMonthTask(DateTime date) async {
    try {
      final taskSchemaList = await IsarDB.isar.tasks
          .filter()
          .repeatEqualTo("month")
          .everyMonthIsNotNull()
          .findAll();

      List<TaskModel> tasks = [];

      for (var taskSchema in taskSchemaList) {
        var detailedPlanSchema = await IsarDB.isar.detailedPlans
            .filter()
            .idEqualTo(taskSchema.detailedPlanId)
            .findFirst();

        if (detailedPlanSchema == null) continue;

        var taskFrom = taskSchema.from.copyWith(
          year: date.year,
          month: date.month,
        );
        var taskTo = taskSchema.to.copyWith(
          year: date.year,
          month: date.month,
        );

        if (taskSchema.terminate != null &&
            taskTo.isAfter(taskSchema.terminate!)) {
          continue;
        }

        taskSchema.from = taskFrom;
        taskSchema.to = taskTo;
        tasks.add(TaskModel.fromSchema(taskSchema, detailedPlanSchema));
      }

      return tasks;
    } catch (error) {
      rethrow;
    }
  }

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
        ..repeat = repeat
        ..weekday = repeat == "weekdays" ? true : false
        ..weekend = repeat == "weekend" ? true : false
        ..everyDay = repeat == "day" ? true : false
        ..everyWeek = repeat == "week" ? from.weekday : null
        ..everyMonth = repeat == "month" ? from.day : null;

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

  Future<bool> deleteTask(int taskId) async {
    try {
      bool success = false;

      await IsarDB.isar.writeTxn(() async {
        success = await IsarDB.isar.tasks.delete(taskId);
      });

      return success;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> stopTask(int taskId, DateTime terminate) async {
    try {
      var taskSchema =
          await IsarDB.isar.tasks.filter().idEqualTo(taskId).findFirst();

      if (taskSchema == null) return false;

      taskSchema.terminate = terminate;

      await IsarDB.isar.writeTxn(() async {
        await IsarDB.isar.tasks.put(taskSchema);
      });

      return true;
    } catch (error) {
      rethrow;
    }
  }
}
