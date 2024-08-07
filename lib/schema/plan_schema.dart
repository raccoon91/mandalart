import 'package:isar/isar.dart';

part 'plan_schema.g.dart';

@collection
class Plan {
  Id id = Isar.autoIncrement;

  late int projectId;

  String? name;

  String? description;

  int? color;

  String? style;

  bool delete = false;
}
