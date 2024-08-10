import 'package:isar/isar.dart';

part 'task_schema.g.dart';

@collection
class Task {
  Id id = Isar.autoIncrement;

  late int detailedPlanId;

  late DateTime from;

  late DateTime to;

  DateTime? terminate;

  bool allDay = false;

  String? repeat;

  int? color;

  String? style;

  bool delete = false;
}
