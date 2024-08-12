import 'package:isar/isar.dart';

part 'task_schema.g.dart';

@collection
class Task {
  Id id = Isar.autoIncrement;

  late int detailedPlanId;

  late DateTime from;

  late DateTime to;

  bool allDay = false;

  String? repeat;

  bool weekday = false;

  bool weekend = false;

  bool everyDay = false;

  int? everyWeek;

  int? everyMonth;

  DateTime? terminate;

  String? description;

  int? color;

  String? style;

  bool delete = false;
}
