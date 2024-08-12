import 'package:isar/isar.dart';

part 'detailed_plan_schema.g.dart';

@collection
class DetailedPlan {
  Id id = Isar.autoIncrement;

  late int planId;

  late int order;

  String? name;

  String? description;

  int? color;

  String? style;

  bool delete = false;
}
