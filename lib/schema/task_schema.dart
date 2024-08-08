import 'package:isar/isar.dart';

part 'task_schema.g.dart';

@collection
class Task {
  Id id = Isar.autoIncrement;

  late int planId;

  late int detailedPlanId;

  late String name;

  String? description;

  late DateTime from;

  late DateTime to;

  int? color;

  String? style;

  bool allDay = false;

  bool everyDay = false;

  int? everyWeek;

  int? everyMonth;

  bool delete = false;
}
