import 'package:isar/isar.dart';

part 'task_schema.g.dart';

@collection
class Task {
  Id id = Isar.autoIncrement;

  late int detailedPlanId;

  late DateTime from;

  late DateTime to;

  DateTime? terminate;

  int? color;

  String? style;

  bool allDay = false;

  bool everyDay = false;

  int? everyWeek;

  int? everyMonth;

  bool delete = false;
}
