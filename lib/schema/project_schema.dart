import 'package:isar/isar.dart';

part 'project_schema.g.dart';

@collection
class Project {
  Id id = Isar.autoIncrement;

  bool progress = false;

  late String name;

  int? color;

  bool delete = false;
}
