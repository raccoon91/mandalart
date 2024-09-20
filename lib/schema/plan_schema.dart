import 'package:isar/isar.dart';
import 'package:mandalart/schema/plan_template_schema.dart';

part 'plan_schema.g.dart';

@collection
class Plan {
  Id id = Isar.autoIncrement;

  late int visionId;

  late int goalId;

  late int order;

  final planTemplate = IsarLink<PlanTemplate>();
}
