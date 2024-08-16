import 'package:isar/isar.dart';

part 'task_schema.g.dart';

@collection
class Task {
  Id id = Isar.autoIncrement;

  late int visionId;

  late int scheduleId;

  late DateTime completed;
}
