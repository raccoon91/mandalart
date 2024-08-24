import 'package:mandalart/db/isar_db.dart';
import 'package:mandalart/repository/repository.dart';
import 'package:mandalart/schema/complete_schema.dart';

class CompleteRepository extends Repository<Complete> {
  CompleteRepository() : super(db: IsarDB.isar.completes);

  Future<Complete?> getComplete(int? scheduleId, DateTime? date) async {
    try {
      if (scheduleId == null || date == null) return null;

      var completeSchema = await findOne((query) {
        return query.scheduleIdEqualTo(scheduleId).completedEqualTo(date);
      });

      return completeSchema;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> createComplete(
    int? visionId,
    int? scheduleId,
    DateTime? date,
  ) async {
    try {
      if (visionId == null || scheduleId == null || date == null) return false;

      var completeSchema = Complete()
        ..visionId = visionId
        ..scheduleId = scheduleId
        ..completed = date;

      await IsarDB.isar.writeTxn(() async {
        await putOne(completeSchema);
      });

      return true;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> deleteComplete(int? completeId) async {
    try {
      if (completeId == null) return false;

      await IsarDB.isar.writeTxn(() async {
        await deleteOne(completeId);
      });

      return true;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> deleteAllComplete(int? visionId) async {
    try {
      if (visionId == null) return false;

      var completeSchemaList = await findAll((query) {
        return query.visionIdEqualTo(visionId);
      });

      var completeIds = completeSchemaList.map((schema) => schema.id).toList();

      await IsarDB.isar.writeTxn(() async {
        await deleteAll(completeIds);
      });

      return true;
    } catch (error) {
      rethrow;
    }
  }
}
