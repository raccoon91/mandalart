import 'package:isar/isar.dart';
import 'package:mandalart/db/isar_db.dart';
import 'package:mandalart/model/task_model.dart';
import 'package:mandalart/schema/schedule_schema.dart';
import 'package:mandalart/schema/task_schema.dart';

class TaskRepository {
  static Future<int> getSize() async {
    try {
      var size = await IsarDB.isar.tasks.getSize(
        includeIndexes: true,
        includeLinks: true,
      );

      return size;
    } catch (error) {
      rethrow;
    }
  }

  static Future<TaskModel?> get(
    int? scheduleId,
    DateTime date,
  ) async {
    try {
      if (scheduleId == null) return null;

      var taskSchema = await IsarDB.isar.tasks
          .filter()
          .schedule((query) => query.idEqualTo(scheduleId))
          .completedEqualTo(date)
          .findFirst();

      if (taskSchema == null || taskSchema.schedule.value == null) return null;

      return TaskModel.fromSchema(taskSchema, taskSchema.schedule.value!);
    } catch (error) {
      rethrow;
    }
  }

  static Future<Schedule?> create(
    int? visionId,
    int? scheduleId,
    DateTime? date,
  ) async {
    try {
      if (visionId == null || scheduleId == null || date == null) return null;

      Schedule? schedule =
          await IsarDB.isar.schedules.where().idEqualTo(scheduleId).findFirst();

      if (schedule == null) return null;

      var taskSchema = Task()
        ..visionId = visionId
        ..schedule.value = schedule
        ..completed = date;

      await IsarDB.isar.writeTxn(() async {
        await IsarDB.isar.tasks.put(taskSchema);
        await taskSchema.schedule.save();
      });

      return schedule;
    } catch (error) {
      rethrow;
    }
  }

  static Future<bool> delete(int? taskId) async {
    try {
      if (taskId == null) return false;

      await IsarDB.isar.writeTxn(() async {
        await IsarDB.isar.tasks.delete(taskId);
      });

      return true;
    } catch (error) {
      rethrow;
    }
  }
}
