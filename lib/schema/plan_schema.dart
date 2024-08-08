import 'package:isar/isar.dart';
import 'package:mandalart/schema/detailed_plan_schema.dart';

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

  final detailedPlans = IsarLinks<DetailedPlan>();
}
