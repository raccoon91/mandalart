import 'package:isar/isar.dart';
import 'package:mandalart/db/isar_db.dart';
import 'package:mandalart/schema/done_schema.dart';

class TodoRepository {
  Future<dynamic> getTodo(
    int? taskId,
    DateTime date,
  ) async {
    try {
      if (taskId == null) return;

      final doneSchema = IsarDB.isar.dones
          .filter()
          .taskIdEqualTo(taskId)
          .dateEqualTo(date)
          .findFirst();

      return doneSchema;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> createTodo(
    int? taskId,
    DateTime? date,
  ) async {
    try {
      if (taskId == null || date == null) return false;

      final doneSchema = Done()
        ..taskId = taskId
        ..date = date;

      await IsarDB.isar.writeTxn(() async {
        await IsarDB.isar.dones.put(doneSchema);
      });

      return true;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> deleteTodo(int? doneId) async {
    try {
      if (doneId == null) return false;

      await IsarDB.isar.writeTxn(() async {
        await IsarDB.isar.dones.delete(doneId);
      });

      return true;
    } catch (error) {
      rethrow;
    }
  }
}
