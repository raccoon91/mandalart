import 'package:isar/isar.dart';
import 'package:mandalart/schema/goal_template_schema.dart';
import 'package:mandalart/schema/plan_schema.dart';

part 'goal_schema.g.dart';

@collection
class Goal {
  Id id = Isar.autoIncrement;

  late int visionId;

  late int order;

  final goalTemplate = IsarLink<GoalTemplate>();

  final plans = IsarLinks<Plan>();
}
