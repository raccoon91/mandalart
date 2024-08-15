import 'package:isar/isar.dart';

part 'done_schema.g.dart';

@collection
class Done {
  Id id = Isar.autoIncrement;

  late int taskId;

  late DateTime date;
}
