import 'package:isar/isar.dart';
import 'package:mandalart/db/isar_db.dart';
import 'package:mandalart/model/task_model.dart';
import 'package:mandalart/schema/detailed_plan_schema.dart';
import 'package:mandalart/schema/task_schema.dart';

class TaskRepository {
  Future<List<TaskModel>?> getTodayTask() async {
    try {
      var today = DateTime.now();
      var fromDate = today
          .subtract(Duration(days: today.weekday))
          .copyWith(hour: 0, minute: 0, second: 0);
      var toDate = today
          .add(Duration(days: DateTime.daysPerWeek - today.weekday - 1))
          .copyWith(hour: 11, minute: 59, second: 59);

      final taskSchemaList = await IsarDB.isar.tasks
          .filter()
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

  // Future<List<TaskModel>?> getEveryDayTask() async {
  //   try {
  //     final taskSchema =
  //         await IsarDB.isar.tasks.filter().everyDayEqualTo(true).findAll();

  //     List<TaskModel> tasks = taskSchema.map(TaskModel.fromSchema).toList();

  //     return tasks;
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  // Future<List<TaskModel>?> getEveryWeekTask(int weekday) async {
  //   try {
  //     final taskSchema =
  //         await IsarDB.isar.tasks.filter().everyWeekEqualTo(weekday).findAll();

  //     List<TaskModel> tasks = taskSchema.map(TaskModel.fromSchema).toList();

  //     return tasks;
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

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
    bool? everyDay,
    int? everyWeek,
    int? everyMonth,
  ) async {
    try {
      final taskSchema = Task()
        ..detailedPlanId = detailedPlanId
        ..from = from.subtract(const Duration(hours: 9))
        ..to = to.subtract(const Duration(hours: 9))
        ..allDay = allDay ?? false
        ..everyDay = everyDay ?? false
        ..everyWeek = everyWeek
        ..everyMonth = everyMonth;

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
