import 'package:isar/isar.dart';
import 'package:mandalart/schema/schedule_schema.dart';

part 'task_schema.g.dart';

@collection
class Task {
  Id id = Isar.autoIncrement;

  late int visionId;

  late DateTime completed;

  final schedule = IsarLink<Schedule>();
}
