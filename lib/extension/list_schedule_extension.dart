import 'package:mandalart/extension/number_extension.dart';
import 'package:mandalart/model/schedule_model.dart';
import 'package:mandalart/schema/schedule_schema.dart';

extension ListScheduleExtension on List<Schedule> {
  List<ScheduleModel> filterAsSchedule(DateTime start) {
    var schemaList = this;

    List<ScheduleModel> schedules = [];

    for (var schema in schemaList) {
      var from = start.copyWith(
        day: schema.day,
        hour: schema.start.numToHour,
        minute: schema.start.numToMinute,
      );

      var to = start.copyWith(
        day: schema.day,
        hour: schema.end.numToHour,
        minute: schema.end.numToMinute,
      );

      if (schema.terminated != null && to.isAfter(schema.terminated!)) {
        continue;
      }

      schedules.add(ScheduleModel.fromSchema(schema, from, to));
    }

    return schedules;
  }

  List<ScheduleModel> filterAsWeekday(DateTime start) {
    var schemaList = this;

    List<ScheduleModel> schedules = [];

    for (var schema in schemaList) {
      for (var calib = 1; calib < 6; calib++) {
        var from = start.copyWith(
          day: start.day + calib,
          hour: schema.start.numToHour,
          minute: schema.start.numToMinute,
        );
        var to = start.copyWith(
          day: start.day + calib,
          hour: schema.end.numToHour,
          minute: schema.end.numToMinute,
        );

        if (schema.terminated != null && to.isAfter(schema.terminated!)) {
          continue;
        }

        schedules.add(ScheduleModel.fromSchema(schema, from, to));
      }
    }

    return schedules;
  }

  List<ScheduleModel> filterAsWeekend(DateTime start) {
    var schemaList = this;

    List<ScheduleModel> schedules = [];

    for (var schema in schemaList) {
      for (var calib in [0, 6]) {
        var from = start.copyWith(
          day: start.day + calib,
          hour: schema.start.numToHour,
          minute: schema.start.numToMinute,
        );
        var to = start.copyWith(
          day: start.day + calib,
          hour: schema.end.numToHour,
          minute: schema.end.numToMinute,
        );

        if (schema.terminated != null && to.isAfter(schema.terminated!)) {
          continue;
        }

        schedules.add(ScheduleModel.fromSchema(schema, from, to));
      }
    }

    return schedules;
  }

  List<ScheduleModel> filterAsEveryDay(DateTime start) {
    var schemaList = this;

    List<ScheduleModel> schedules = [];

    for (var schema in schemaList) {
      for (var calib = 0; calib < 7; calib++) {
        var from = start.copyWith(
          day: start.day + calib,
          hour: schema.start.numToHour,
          minute: schema.start.numToMinute,
        );
        var to = start.copyWith(
          day: start.day + calib,
          hour: schema.end.numToHour,
          minute: schema.end.numToMinute,
        );

        if (schema.terminated != null && to.isAfter(schema.terminated!)) {
          continue;
        }

        schedules.add(ScheduleModel.fromSchema(schema, from, to));
      }
    }

    return schedules;
  }

  List<ScheduleModel> filterAsEveryWeek(DateTime start) {
    var schemaList = this;

    List<ScheduleModel> schedules = [];

    for (var schema in schemaList) {
      var from = start.copyWith(
        day: start.day + (schema.weekday == 7 ? 0 : schema.weekday),
        hour: schema.start.numToHour,
        minute: schema.start.numToMinute,
      );
      var to = start.copyWith(
        day: start.day + (schema.weekday == 7 ? 0 : schema.weekday),
        hour: schema.end.numToHour,
        minute: schema.end.numToMinute,
      );

      if (schema.terminated != null && to.isAfter(schema.terminated!)) {
        continue;
      }

      schedules.add(ScheduleModel.fromSchema(schema, from, to));
    }

    return schedules;
  }

  List<ScheduleModel> filterAsEveryMonth(DateTime start) {
    var schemaList = this;

    List<ScheduleModel> schedules = [];

    for (var schema in schemaList) {
      var from = start.copyWith(
        day: schema.day,
        hour: schema.start.numToHour,
        minute: schema.start.numToMinute,
      );
      var to = start.copyWith(
        day: schema.day,
        hour: schema.end.numToHour,
        minute: schema.end.numToMinute,
      );

      if (schema.terminated != null && to.isAfter(schema.terminated!)) {
        continue;
      }

      schedules.add(ScheduleModel.fromSchema(schema, from, to));
    }

    return schedules;
  }
}
