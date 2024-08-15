import 'package:isar/isar.dart';

part 'plan_schema.g.dart';

@collection
class Plan {
  Id id = Isar.autoIncrement;

  late int visionId;

  late int goalId;

  late int order;

  String? name;

  String? description;

  int? color;

  String? style;

  bool isDelete = false;
}
