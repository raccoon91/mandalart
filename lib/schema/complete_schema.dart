import 'package:isar/isar.dart';

part 'complete_schema.g.dart';

@collection
class Complete {
  Id id = Isar.autoIncrement;

  late int visionId;

  late int scheduleId;

  late DateTime completed;
}
