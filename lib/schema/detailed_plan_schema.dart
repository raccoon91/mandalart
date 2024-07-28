import 'package:isar/isar.dart';

part 'detailed_plan_schema.g.dart';

@collection
class DetailedPlan {
  Id id = Isar.autoIncrement;

  late int planId;

  String? name;

  int? color;

  bool delete = false;
}
