import 'package:isar/isar.dart';
import 'package:mandalart/schema/plan_schema.dart';

part 'schedule_schema.g.dart';

@collection
class Schedule {
  Id id = Isar.autoIncrement;

  late int visionId;

  late int year;

  late int month;

  late int day;

  late int start;

  late int end;

  late int weekday;

  late int weekOfMonth;

  String? repeat;

  bool isAllDay = false;

  DateTime? terminated;

  String? description;

  int? color;

  String? style;

  bool isDelete = false;

  final plan = IsarLink<Plan>();
}
