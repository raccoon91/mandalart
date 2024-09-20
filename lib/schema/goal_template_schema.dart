import 'package:isar/isar.dart';
import 'package:mandalart/schema/plan_template_schema.dart';

part 'goal_template_schema.g.dart';

@collection
class GoalTemplate {
  Id id = Isar.autoIncrement;

  String? name;

  String? color;

  String? description;

  String? style;

  final planTemplates = IsarLinks<PlanTemplate>();
}
