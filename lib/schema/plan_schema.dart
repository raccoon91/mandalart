import 'package:isar/isar.dart';

part 'plan_schema.g.dart';

@collection
class Plan {
  Id id = Isar.autoIncrement;

  late int projectId;

  String? name;

  int? color;

  bool delete = false;
}
