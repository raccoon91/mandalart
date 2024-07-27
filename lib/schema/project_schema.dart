import 'package:isar/isar.dart';
import 'package:mandalart/schema/main_target_schema.dart';

part 'project_schema.g.dart';

@collection
class Project {
  Id id = Isar.autoIncrement;

  late String name;

  int? color;

  bool isDefault = false;

  final mainTargets = IsarLinks<MainTarget>();
}
