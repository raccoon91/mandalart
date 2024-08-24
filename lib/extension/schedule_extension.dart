import 'package:mandalart/extension/number_extension.dart';
import 'package:mandalart/schema/schedule_schema.dart';

extension ScheduleExtension on Schedule {
  DateTime get fromOfSchedule {
    var schedule = this;

    var from = DateTime(
      schedule.year,
      schedule.month,
      schedule.day,
      schedule.start.numToHour,
      schedule.start.numToMinute,
    );

    return from;
  }

  DateTime get toOfSchedule {
    var schedule = this;

    var to = DateTime(
      schedule.year,
      schedule.month,
      schedule.day,
      schedule.end.numToHour,
      schedule.end.numToMinute,
    );

    return to;
  }
}
