import 'package:mandalart/db/isar_db.dart';
import 'package:mandalart/extension/datetime_extension.dart';
import 'package:mandalart/extension/list_schedule_extension.dart';
import 'package:mandalart/extension/schedule_extension.dart';
import 'package:mandalart/model/schedule_model.dart';
import 'package:mandalart/repository/repository.dart';
import 'package:mandalart/schema/plan_schema.dart';
import 'package:mandalart/schema/schedule_schema.dart';

class ScheduleRepository extends Repository<Schedule> {
  ScheduleRepository() : super(db: IsarDB.isar.schedules);

  Future<ScheduleModel?> getSchedule({int? scheduleId}) async {
    try {
      if (scheduleId == null) return null;

      final scheduleSchema = await findOne(builder: (query) {
        return query.idEqualTo(scheduleId).isDeleteEqualTo(false);
      });

      if (scheduleSchema == null) return null;

      var from = scheduleSchema.fromOfSchedule;
      var to = scheduleSchema.toOfSchedule;

      var schedule = ScheduleModel.fromSchema(scheduleSchema, from, to);

      return schedule;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<ScheduleModel>> getThisWeek({required DateTime start}) async {
    try {
      var startDay = start.day;
      var endDay = startDay + 6;

      final scheduleSchemaList = await findAll(builder: (query) {
        return query
            .repeatIsNull()
            .dayGreaterThan(startDay, include: true)
            .dayLessThan(endDay, include: true)
            .isDeleteEqualTo(false);
      });

      var schedules = scheduleSchemaList.filterAsSchedule(start);

      return schedules;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<ScheduleModel>?> getWeekDay({required DateTime start}) async {
    try {
      final scheduleSchemaList = await findAll(builder: (query) {
        return query.repeatEqualTo('weekdays').isDeleteEqualTo(false);
      });

      var schedules = scheduleSchemaList.filterAsWeekday(start);

      return schedules;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<ScheduleModel>?> getWeekend({required DateTime start}) async {
    try {
      final scheduleSchemaList = await findAll(builder: (query) {
        return query.repeatEqualTo('weekend').isDeleteEqualTo(false);
      });

      var schedules = scheduleSchemaList.filterAsWeekend(start);

      return schedules;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<ScheduleModel>?> getEveryDay({required DateTime start}) async {
    try {
      final scheduleSchemaList = await findAll(builder: (query) {
        return query.repeatEqualTo('day').isDeleteEqualTo(false);
      });

      var schedules = scheduleSchemaList.filterAsEveryDay(start);

      return schedules;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<ScheduleModel>?> getEveryWeek({required DateTime start}) async {
    try {
      final scheduleSchemaList = await findAll(builder: (query) {
        return query.repeatEqualTo('week').isDeleteEqualTo(false);
      });

      var schedules = scheduleSchemaList.filterAsEveryWeek(start);

      return schedules;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<ScheduleModel>?> getEveryMonth({required DateTime start}) async {
    try {
      var startDay = start.day;
      var endDay = startDay + 6;

      final scheduleSchemaList = await findAll(builder: (query) {
        return query
            .repeatEqualTo('month')
            .dayGreaterThan(startDay, include: true)
            .dayLessThan(endDay, include: true)
            .isDeleteEqualTo(false);
      });

      var schedules = scheduleSchemaList.filterAsEveryMonth(start);

      return schedules;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> createSchedule({
    Plan? plan,
    required DateTime from,
    required DateTime to,
    bool? isAllDay,
    String? repeat,
  }) async {
    try {
      if (plan == null) return false;

      final scheduleSchema = Schedule()
        ..visionId = plan.visionId
        ..plan.value = plan
        ..year = from.year
        ..month = from.month
        ..day = from.day
        ..start = from.timeToNum
        ..end = to.timeToNum
        ..weekday = from.weekday
        ..weekOfMonth = from.weekOfMonth
        ..isAllDay = isAllDay ?? false
        ..repeat = repeat;

      await IsarDB.isar.writeTxn(() async {
        await putOne(schema: scheduleSchema);

        await scheduleSchema.plan.save();
      });

      return true;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> deleteSchedule({required int scheduleId}) async {
    try {
      await IsarDB.isar.writeTxn(() async {
        await deleteOne(id: scheduleId);
      });

      return true;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> stopSchedule({required int scheduleId, required DateTime terminated}) async {
    try {
      var schema = await findOne(builder: (query) {
        return query.idEqualTo(scheduleId).isDeleteEqualTo(false);
      });

      if (schema == null) return false;

      schema.terminated = terminated;

      await IsarDB.isar.writeTxn(() async {
        await putOne(schema: schema);
      });

      return true;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> deleteAllSchedule({int? visionId}) async {
    try {
      if (visionId == null) return false;

      var scheduleSchemaList = await findAll(builder: (query) {
        return query.visionIdEqualTo(visionId);
      });

      var scheduleIds = scheduleSchemaList.map((schema) => schema.id).toList();

      await IsarDB.isar.writeTxn(() async {
        await deleteAll(ids: scheduleIds);
      });

      return true;
    } catch (error) {
      rethrow;
    }
  }
}
