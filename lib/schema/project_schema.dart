import 'package:isar/isar.dart';
import 'package:mandalart/schema/plan_schema.dart';

part 'project_schema.g.dart';

@collection
class Project {
  Id id = Isar.autoIncrement;

  bool progress = false;

  late String name;

  String? description;

  int? color;

  String? style;

  bool delete = false;

  final plans = IsarLinks<Plan>();
}
