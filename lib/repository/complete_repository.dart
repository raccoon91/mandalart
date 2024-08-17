import 'package:isar/isar.dart';
import 'package:mandalart/db/isar_db.dart';
import 'package:mandalart/schema/complete_schema.dart';
import 'package:mandalart/schema/vision_schema.dart';

class CompleteRepository {
  static Future<int> getSize() async {
    try {
      var size = await IsarDB.isar.completes.getSize(
        includeIndexes: true,
        includeLinks: true,
      );

      return size;
    } catch (error) {
      rethrow;
    }
  }

  static Future<Complete?> get(int? scheduleId, DateTime date) async {
    try {
      if (scheduleId == null) return null;

      var completeSchema = await IsarDB.isar.completes
          .filter()
          .scheduleIdEqualTo(scheduleId)
          .completedEqualTo(date)
          .findFirst();

      return completeSchema;
    } catch (error) {
      rethrow;
    }
  }

  static Future<bool> create(
    int? scheduleId,
    DateTime? date,
  ) async {
    try {
      if (scheduleId == null || date == null) return false;

      var visionId = await IsarDB.isar.visions
          .filter()
          .inProgressEqualTo(true)
          .idProperty()
          .findFirst();

      if (visionId == null) return false;

      var completeSchema = Complete()
        ..visionId = visionId
        ..scheduleId = scheduleId
        ..completed = date;

      await IsarDB.isar.writeTxn(() async {
        await IsarDB.isar.completes.put(completeSchema);
      });

      return true;
    } catch (error) {
      rethrow;
    }
  }

  static Future<bool> delete(int? completeId) async {
    try {
      if (completeId == null) return false;

      await IsarDB.isar.writeTxn(() async {
        await IsarDB.isar.completes.delete(completeId);
      });

      return true;
    } catch (error) {
      rethrow;
    }
  }
}
