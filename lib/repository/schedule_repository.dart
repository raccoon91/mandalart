import 'package:isar/isar.dart';
import 'package:mandalart/db/isar_db.dart';
import 'package:mandalart/extension/number_format_extension.dart';
import 'package:mandalart/extension/time_format_extension.dart';
import 'package:mandalart/extension/week_of_month_extension.dart';
import 'package:mandalart/model/schedule_model.dart';
import 'package:mandalart/schema/plan_schema.dart';
import 'package:mandalart/schema/schedule_schema.dart';

class ScheduleRepository {
  static Future<int> getSize() async {
    try {
      final size = await IsarDB.isar.schedules.getSize(
        includeIndexes: true,
        includeLinks: true,
      );

      return size;
    } catch (error) {
      rethrow;
    }
  }

  static Future<ScheduleModel?> get(int? scheduleId) async {
    try {
      if (scheduleId == null) return null;

      final scheduleSchema = await IsarDB.isar.schedules
          .filter()
          .idEqualTo(scheduleId)
          .isDeleteEqualTo(false)
          .findFirst();

      if (scheduleSchema == null) return null;

      var from = DateTime(
        scheduleSchema.year,
        scheduleSchema.month,
        scheduleSchema.day,
        scheduleSchema.start.toHour(),
        scheduleSchema.start.toMinute(),
      );
      var to = DateTime(
        scheduleSchema.year,
        scheduleSchema.month,
        scheduleSchema.day,
        scheduleSchema.end.toHour(),
        scheduleSchema.end.toMinute(),
      );

      ScheduleModel schedule = ScheduleModel.fromSchema(
        scheduleSchema,
        from,
        to,
      );

      return schedule;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<ScheduleModel>?> getThisWeek(DateTime date) async {
    try {
      var startDay = date.day;
      var endDay = startDay + 6;

      final scheduleSchemaList = await IsarDB.isar.schedules
          .filter()
          .repeatIsNull()
          .dayGreaterThan(startDay, include: true)
          .dayLessThan(endDay, include: true)
          .findAll();

      List<ScheduleModel> schedules = [];

      for (var schema in scheduleSchemaList) {
        var from = date.copyWith(
          day: schema.day,
          hour: schema.start.toHour(),
          minute: schema.start.toMinute(),
        );
        var to = date.copyWith(
          day: schema.day,
          hour: schema.end.toHour(),
          minute: schema.end.toMinute(),
        );

        if (schema.terminated != null && to.isAfter(schema.terminated!)) {
          continue;
        }

        schedules.add(ScheduleModel.fromSchema(schema, from, to));
      }

      return schedules;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<ScheduleModel>?> getWeekDay(DateTime date) async {
    try {
      final scheduleSchemaList = await IsarDB.isar.schedules
          .filter()
          .repeatEqualTo('weekdays')
          .isDeleteEqualTo(false)
          .findAll();

      List<ScheduleModel> schedules = [];

      for (var schema in scheduleSchemaList) {
        for (var calib = 1; calib < 6; calib++) {
          var from = date.copyWith(
            day: date.day + calib,
            hour: schema.start.toHour(),
            minute: schema.start.toMinute(),
          );
          var to = date.copyWith(
            day: date.day + calib,
            hour: schema.end.toHour(),
            minute: schema.end.toMinute(),
          );

          if (schema.terminated != null && to.isAfter(schema.terminated!)) {
            continue;
          }

          schedules.add(ScheduleModel.fromSchema(schema, from, to));
        }
      }

      return schedules;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<ScheduleModel>?> getWeekend(DateTime date) async {
    try {
      final scheduleSchemaList = await IsarDB.isar.schedules
          .filter()
          .repeatEqualTo('weekend')
          .isDeleteEqualTo(false)
          .findAll();

      List<ScheduleModel> schedules = [];

      for (var schema in scheduleSchemaList) {
        for (var calib in [0, 6]) {
          var from = date.copyWith(
            day: date.day + calib,
            hour: schema.start.toHour(),
            minute: schema.start.toMinute(),
          );
          var to = date.copyWith(
            day: date.day + calib,
            hour: schema.end.toHour(),
            minute: schema.end.toMinute(),
          );

          if (schema.terminated != null && to.isAfter(schema.terminated!)) {
            continue;
          }

          schedules.add(ScheduleModel.fromSchema(schema, from, to));
        }
      }

      return schedules;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<ScheduleModel>?> getEveryDay(DateTime date) async {
    try {
      final scheduleSchemaList = await IsarDB.isar.schedules
          .filter()
          .repeatEqualTo('day')
          .isDeleteEqualTo(false)
          .findAll();

      List<ScheduleModel> schedules = [];

      for (var schema in scheduleSchemaList) {
        for (var calib = 0; calib < 7; calib++) {
          var from = date.copyWith(
            day: date.day + calib,
            hour: schema.start.toHour(),
            minute: schema.start.toMinute(),
          );
          var to = date.copyWith(
            day: date.day + calib,
            hour: schema.end.toHour(),
            minute: schema.end.toMinute(),
          );

          if (schema.terminated != null && to.isAfter(schema.terminated!)) {
            continue;
          }

          schedules.add(ScheduleModel.fromSchema(schema, from, to));
        }
      }

      return schedules;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<ScheduleModel>?> getEveryWeek(DateTime date) async {
    try {
      final scheduleSchemaList = await IsarDB.isar.schedules
          .filter()
          .repeatEqualTo('week')
          .isDeleteEqualTo(false)
          .findAll();

      List<ScheduleModel> schedules = [];

      for (var schema in scheduleSchemaList) {
        var from = date.copyWith(
          day: date.day + (schema.weekday == 7 ? 0 : schema.weekday),
          hour: schema.start.toHour(),
          minute: schema.start.toMinute(),
        );
        var to = date.copyWith(
          day: date.day + (schema.weekday == 7 ? 0 : schema.weekday),
          hour: schema.end.toHour(),
          minute: schema.end.toMinute(),
        );

        if (schema.terminated != null && to.isAfter(schema.terminated!)) {
          continue;
        }

        schedules.add(ScheduleModel.fromSchema(schema, from, to));
      }

      return schedules;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<ScheduleModel>?> getEveryMonth(DateTime date) async {
    try {
      var startDay = date.day;
      var endDay = startDay + 6;

      final scheduleSchemaList = await IsarDB.isar.schedules
          .filter()
          .repeatEqualTo('month')
          .dayGreaterThan(startDay, include: true)
          .dayLessThan(endDay, include: true)
          .isDeleteEqualTo(false)
          .findAll();

      List<ScheduleModel> schedules = [];

      for (var schema in scheduleSchemaList) {
        var from = date.copyWith(
          day: schema.day,
          hour: schema.start.toHour(),
          minute: schema.start.toMinute(),
        );
        var to = date.copyWith(
          day: schema.day,
          hour: schema.end.toHour(),
          minute: schema.end.toMinute(),
        );

        if (schema.terminated != null && to.isAfter(schema.terminated!)) {
          continue;
        }

        schedules.add(ScheduleModel.fromSchema(schema, from, to));
      }

      return schedules;
    } catch (error) {
      rethrow;
    }
  }

  static Future<ScheduleModel?> create(
    int visionId,
    int planId,
    DateTime from,
    DateTime to,
    bool? isAllDay,
    String? repeat,
  ) async {
    try {
      Plan? plan =
          await IsarDB.isar.plans.where().idEqualTo(planId).findFirst();

      if (plan == null) return null;

      final scheduleSchema = Schedule()
        ..visionId = visionId
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
        await IsarDB.isar.schedules.put(scheduleSchema);
        await scheduleSchema.plan.save();
      });

      final schedule = ScheduleModel.fromSchema(scheduleSchema, from, to);

      return schedule;
    } catch (error) {
      rethrow;
    }
  }

  static Future<bool> delete(int scheduleId) async {
    try {
      bool success = false;

      await IsarDB.isar.writeTxn(() async {
        success = await IsarDB.isar.schedules.delete(scheduleId);
      });

      return success;
    } catch (error) {
      rethrow;
    }
  }

  static Future<bool> stop(int scheduleId, DateTime terminated) async {
    try {
      var schema = await IsarDB.isar.schedules
          .filter()
          .idEqualTo(scheduleId)
          .isDeleteEqualTo(false)
          .findFirst();

      if (schema == null) return false;

      schema.terminated = terminated;

      await IsarDB.isar.writeTxn(() async {
        await IsarDB.isar.schedules.put(schema);
      });

      return true;
    } catch (error) {
      rethrow;
    }
  }
}
